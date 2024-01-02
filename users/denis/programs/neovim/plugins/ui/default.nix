{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      barbar-nvim # Tabline plugin
      {
        plugin = barbecue-nvim; # Context bar
        type = "lua";
        config = "require('barbecue').setup()";
      }
      {
        plugin = statuscol-nvim; # Status column
        type = "lua";
        config = "require('statuscol').setup()";
      }
      {
        plugin = satellite-nvim; # scrollbar decorations
        type = "lua";
        config = "require('satellite').setup()";
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./lualine.lua;
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = builtins.readFile ./neo-tree.lua; # Setup should be called for tree be enabled at startup
      }
      nvim-web-devicons # Additional icons
    ];

    extraPackages = with pkgs; [
    ];
  };
}
