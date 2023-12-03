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
      luasnip
      cmp_luasnip
      cmp-path
      cmp-buffer
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
    ];
  };
}
