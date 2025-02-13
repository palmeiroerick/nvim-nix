{inputs, ...}: final: prev: let
  pkgs = prev;

  build = pkgs.callPackage ./build.nix { inherit pkgs; };

  plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    tokyonight-nvim  
    nvim-lspconfig
  ];

  extraPackages = with pkgs; [
    lua-language-server
    clang-tools
    nil
  ];
in {
  neovim = build {
    inherit plugins extraPackages;
  };
}
