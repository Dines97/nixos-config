{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = hmts-nvim;
        type = "lua";
      }
    ];
    extraPackages = with pkgs; [
      # Nix
      # rnix-lsp
      # nixpkgs-fmt
      nil
      alejandra
      statix
    ];
  };
}
