{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Nix
      # unstable.rnix-lsp
      # unstable.nixpkgs-fmt
      unstable.nil
      unstable.alejandra
      unstable.statix

      # Neovim
      xclip
      vale
      unstable.sumneko-lua-language-server
      unstable.gopls
      unstable.nodePackages.yaml-language-server
      unstable.omnisharp-roslyn
      unstable.nodePackages.prettier
      unstable.nodePackages.vue-language-server
      # unstable.python310Packages.jedi-language-server

      unstable.nodePackages.pyright
      unstable.python310Packages.black
    ];

    # plugins = with pkgs.unstable.vimPlugins; [
    #   {
    #     plugin = nvim-treesitter.withAllGrammars;
    #     type = "lua";
    #     config = builtins.readFile ./treesitter.lua;
    #   }
    #   {
    #     plugin = nvim-treesitter-context;
    #     type = "lua";
    #     config = builtins.readFile ./treesitter_context.lua;
    #   }
    #   {
    #     plugin = nvim-lspconfig;
    #     type = "lua";
    #     config = builtins.readFile ./nvim_lspconfig.lua;
    #   }
    #   {
    #     plugin = omnisharp-extended-lsp-nvim;
    #     type = "lua";
    #   }
    #   {
    #     plugin = which-key-nvim;
    #     type = "lua";
    #   }
    #   {
    #     plugin = cmp-nvim-lsp;
    #     type = "lua";
    #   }
    #   {
    #     plugin = nvim-notify;
    #     type = "lua";
    #   }
    # ];
  };
}
