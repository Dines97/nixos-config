{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    extraLuaConfig = builtins.readFile ./default.lua;

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
