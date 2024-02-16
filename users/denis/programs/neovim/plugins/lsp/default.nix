{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    extraLuaConfig = lib.mkBefore (builtins.readFile ./default.lua);

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./nvim-lspconfig.lua;
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./nvim-cmp.lua;
      }
      cmp-path
      cmp-buffer
      cmp-nvim-lsp

      luasnip
      cmp_luasnip
    ];

    extraPackages = with pkgs; [
      # Generic
      nodePackages.prettier
    ];
  };
}
