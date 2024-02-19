{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-dap;
        type = "lua";
        config = builtins.readFile ./nvim-dap.lua;
      }
      {
        plugin = nvim-dap-ui;
        type = "lua";
        config = builtins.readFile ./nvim-dap-ui.lua;
      }
      {
        plugin = nvim-dap-virtual-text;
        type = "lua";
        config =
          # lua
          ''
            require("nvim-dap-virtual-text").setup()
          '';
      }
    ];

    extraPackages = with pkgs; [
    ];
  };
}
