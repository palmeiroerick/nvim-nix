{...}: final: prev: let
  pkgs = prev;

  build = pkgs.callPackage ./build.nix { inherit pkgs; };

  plugins = with pkgs.vimPlugins; [
    tokyonight-nvim  
    nvim-lspconfig
  ];

  extraPackages = with pkgs; [
    nil
  ];
in {
  neovim = build {
    inherit plugins extraPackages;
  };
}