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

      omnisharp-extended-lsp-nvim

      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile ./null-ls-nvim.lua;
      }
    ];

    extraPackages = with pkgs; [
      # Generic
      nodePackages.prettier

      # Helm
      helm-ls

      # Nix
      # rnix-lsp
      # nixpkgs-fmt
      nil
      alejandra
      statix

      # Lua
      sumneko-lua-language-server

      # Terraform
      terraform-ls
      tflint

      # Yaml
      nodePackages.yaml-language-server

      # C#
      omnisharp-roslyn

      # Python
      nodePackages.pyright
      python310Packages.black
      # python310Packages.jedi-language-server

      # Ansible
      ansible-language-server
      ansible-lint

      # JavaScript
      nodePackages.vue-language-server
      nodePackages.volar # Language server for Vue

      # Dockerfile
      dockerfile-language-server-nodejs
    ];
  };
}
