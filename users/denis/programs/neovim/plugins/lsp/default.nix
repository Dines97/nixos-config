{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
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

      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile ./null-ls-nvim.lua;
      }
    ];

    extraPackages = with pkgs; [
      # Generic
      nodePackages.prettier

      # Lua
      sumneko-lua-language-server

      # Terraform
      terraform-ls
      tflint

      # Yaml
      nodePackages.yaml-language-server

      # Python
      nodePackages.pyright
      python310Packages.black
      # python310Packages.jedi-language-server

      # JavaScript
      nodePackages.vue-language-server
      nodePackages.volar # Language server for Vue

      # Dockerfile
      dockerfile-language-server-nodejs
    ];
  };
}
