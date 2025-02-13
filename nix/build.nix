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

    nvim = stdenv.mkDerivation {
      name = "neovim";
      src = ../config;

      buildPhase = ''
        mkdir -p $out/lua
      '';

      installPhase = ''
        cp init.lua $out/init.lua
        cp -r lua/* $out/lua/
      '';
    };

    initLua = ''
      vim.loader.enable()
      vim.opt.rtp:prepend('${nvim}')
      dofile('${nvim}/init.lua')
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
