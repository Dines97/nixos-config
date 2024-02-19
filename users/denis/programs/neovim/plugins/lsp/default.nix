{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = lib.mkBefore (builtins.readFile ./nvim-lspconfig.lua);
      }
      otter-nvim # Embedded language lsp features
      virtual-types-nvim # Virtual text for type annotations
      workspace-diagnostics-nvim # Full workspace analyze for lsp

      luasnip
    ];

    extraPackages = with pkgs; [
    ];
  };
}
