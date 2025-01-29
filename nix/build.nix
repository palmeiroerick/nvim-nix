{
  pkgs,
  lib,
  stdenv,
}:
with lib;
  {
    plugins ? [],
    extraPackages ? [],
  }: let
    neovim-unwrapped = pkgs.neovim-unwrapped;

    normalizedPlugins = map (x: {plugin = x;}) plugins;

    neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
      plugins = normalizedPlugins;
    };

    nvimRtp = stdenv.mkDerivation {
      name = "neovim";
      src = ../config;

      buildPhase = ''
        mkdir -p $out/config
        mkdir -p $out/lua
        rm init.lua
      '';

      installPhase = ''
        cp -r lua $out/lua
        rm -r lua
      '';
    };

    initLua = ''
      vim.loader.enable()
      vim.opt.rtp:prepend('${nvimRtp}/lua')
      ${builtins.readFile ../config/init.lua}
    '';

    extraMakeWrapperArgs = builtins.concatStringsSep " " (
      (optional (extraPackages != [])
        ''--prefix PATH : "${makeBinPath extraPackages}"'')
    );

    neovim-wrapped = pkgs.wrapNeovimUnstable neovim-unwrapped (neovimConfig
      // {
        luaRcContent = initLua;
        wrapperArgs =
          escapeShellArgs neovimConfig.wrapperArgs
          + " "
          + extraMakeWrapperArgs;
        wrapRc = true;
      });
  in
    neovim-wrapped.overrideAttrs (attrs: {
      buildPhase = attrs.buildPhase;
      meta.mainProgram = attrs.meta.mainProgram;
    })
