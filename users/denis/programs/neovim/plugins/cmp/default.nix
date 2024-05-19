{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./nvim-cmp.lua;
      }
      cmp-buffer
      cmp-nvim-lsp
      cmp-path

      cmp_luasnip
      luasnip
    ];

    extraPackages = with pkgs; [
      # Required for luasnip
      luajitPackages.jsregexp
    ];
  };
}
