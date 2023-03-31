{
  config,
  pkgs,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      package = pkgs.unstable.neovim-unwrapped;
      # package = pkgs.neovim-nightly;
      # defaultEditor = true;

      extraLuaConfig = builtins.readFile ./configs/nvim/init.lua;

      plugins = with pkgs.unstable;
      with pkgs.unstable.vimUtils;
      with pkgs.unstable.vimPlugins; [
        {
          plugin = comment-nvim;
          type = "lua";
          # Setup should be called for default keybindings
          config = "require('Comment').setup()";
        }
        {
          plugin = barbar-nvim;
        }
        {
          plugin = mini-nvim;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/mini.lua;
        }
        {
          plugin = buildVimPluginFrom2Nix {
            pname = "tmux.nvim";
            version = "2023-3-11";
            src = fetchFromGitHub {
              owner = "aserowy";
              repo = "tmux.nvim";
              rev = "9ba03cc5dfb30f1dc9eb50d0796dfdd52c5f454e";
              sha256 = "sha256-ZBnQFKe8gySFQ9v6j4C/F/mq+bCH1n8G42AlBx6MbXY=";
            };
            meta.homepage = "https://github.com/aserowy/tmux.nvim/";
          };
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/tmux.lua;
        }
        {
          plugin = null-ls-nvim;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/null_ls.lua;
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/lualine.lua;
        }

        plenary-nvim
        nvim-web-devicons
        nui-nvim
        {
          plugin = nvim-notify;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/notify.lua;
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/treesitter.lua;
        }
        {
          plugin = onedark-nvim;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/onedark.lua;
        }
        {
          plugin = neo-tree-nvim;
          type = "lua";
          # Setup should be called for tree be enabled at startup
          config = "require('neo-tree').setup()";
        }
        cmp-nvim-lsp
        omnisharp-extended-lsp-nvim
        {
          plugin = neodev-nvim;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/neodev.lua;
        }
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/nvim_lspconfig.lua;
        }
        cmp-path
        luasnip
        cmp_luasnip
        cmp-buffer
        {
          plugin = nvim-cmp;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/nvim_cmp.lua;
        }
        {
          plugin = which-key-nvim;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/which_key.lua;
        }
        {
          plugin = legendary-nvim;
          type = "lua";
          config = builtins.readFile ./configs/nvim/plugins/legendary.lua;
        }
      ];

      extraPackages = with pkgs; [
        # Nix
        # unstable.rnix-lsp
        # unstable.nixpkgs-fmt
        unstable.nil
        unstable.alejandra
        unstable.statix

        # Mix
        xclip
        vale
        unstable.nodePackages.prettier
        unstable.nodePackages.vue-language-server

        # Lua
        unstable.sumneko-lua-language-server

        # Go
        unstable.gopls

        # Yaml
        unstable.nodePackages.yaml-language-server

        # C#
        unstable.omnisharp-roslyn

        # Python
        unstable.nodePackages.pyright
        unstable.python310Packages.black
        # unstable.python310Packages.jedi-language-server
      ];
    };
  };
}
