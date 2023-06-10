{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    # package = pkgs.neovim-nightly;
    # defaultEditor = true;

    extraLuaConfig = builtins.readFile ./configs/nvim/init.lua;

    plugins = with pkgs.vimUtils;
    with pkgs.vimPlugins; [
      plenary-nvim # Required for most of the plugins
      nvim-web-devicons # Additional icons
      dressing-nvim # vim.ui interface improvement
      {
        plugin = flutter-tools-nvim;
        type = "lua";
        config = "require('flutter-tools').setup()";
      }

      barbar-nvim # Tabline plugin
      nvim-navic # Current code context
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
        plugin = indent-blankline-nvim; # Indention line
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/indent-blankline.lua;
      }
      {
        plugin = gitsigns-nvim; # Show git signs in sidebar
        type = "lua";
        config = "require('gitsigns').setup()"; # Setup need to be called for gitsigns to appear
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/telescope.lua;
      }
      telescope-fzf-native-nvim
      {
        #FIXME: Doesn't work for now
        plugin = sqlite-lua; # Required for clipboard manager for persistent clipboard
        # type = "lua";
        config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
        # config = "vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'"; # sqlite3 is required by sqlite-lua
      }
      {
        plugin = nvim-neoclip-lua; # Clipboard manager
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/neoclip.lua; # Persistent need be activated separately
      }

      # {
      #   plugin = presence-nvim; # Discord presence plugin
      #   type = "lua";
      #   config = "require('presence').setup()";
      # }
      {
        plugin = comment-nvim; # Commenting plugin
        type = "lua";
        config = "require('Comment').setup()"; # Setup should be called for default keybindings
      }
      {
        plugin = fidget-nvim;
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/fidget.lua;
      }
      {
        plugin = todo-comments-nvim; # Comment highlighting
        type = "lua";
        config = "require('todo-comments').setup()";
      }
      {
        plugin = mini-nvim; # Collection of small modules
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/mini.lua; # Each of module need to be activated separately
      }
      hologram-nvim
      {
        plugin = buildVimPluginFrom2Nix {
          pname = "pets.nvim";
          version = "2023-03-15";
          src = pkgs.fetchFromGitHub {
            owner = "giusgad";
            repo = "pets.nvim";
            rev = "8200520815038a57787d129cc30f9a7575b6802b";
            sha256 = "sha256-obdjCiNyFCGz8Z6eWPL3nQ+kAAwqfbwbpWmMiABCFHw=";
          };
          meta.homepage = "https://github.com/giusgad/pets.nvim/";
        };
        type = "lua";
        config = "require('pets').setup()";
      }
      {
        plugin = buildVimPluginFrom2Nix {
          pname = "knap"; # LaTeX plugin
          version = "2023-01-21";
          src = pkgs.fetchFromGitHub {
            owner = "frabjous";
            repo = "knap";
            rev = "8c083d333b8a82421a521539eb1c450b06c90eb6";
            sha256 = "sha256-lW4QM3kKmxCF/rUj86d3EdAppwBzGomwk5u6N2u9Hbs=";
          };
          meta.homepage = "https://github.com/frabjous/knap/";
        };
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/knap.lua;
      }
      {
        plugin = buildVimPluginFrom2Nix {
          pname = "tmux.nvim";
          version = "2023-03-11";
          src = pkgs.fetchFromGitHub {
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

      lsp-status-nvim
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/lualine.lua;
      }

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
      nvim-treesitter-context
      {
        plugin = onedark-nvim;
        type = "lua";
        config = builtins.readFile ./configs/nvim/plugins/onedark.lua;
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = "require('neo-tree').setup()"; # Setup should be called for tree be enabled at startup
      }
      cmp-nvim-lsp
      omnisharp-extended-lsp-nvim
      {
        plugin = buildVimPluginFrom2Nix {
          pname = "yaml-companion.nvim";
          version = "2023-03-04";
          src = pkgs.fetchFromGitHub {
            owner = "someone-stole-my-name";
            repo = "yaml-companion.nvim";
            rev = "4de1e1546abc461f62dee02fcac6a02debd6eb9e";
            sha256 = "sha256-BmX7hyiIMQfcoUl09Y794HrSDq+cj93T+Z5u3e5wqLc=";
          };
          meta.homepage = "https://github.com/someone-stole-my-name/yaml-companion.nvim/";
        };
      }
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
      # Just for presence
      discord


      sqlite # Required for neoclip

      # Telescope
      ripgrep
      fd

      # Nix
      # rnix-lsp
      # nixpkgs-fmt
      nil
      alejandra
      statix

      # Mix
      xclip
      vale
      nodePackages.prettier
      nodePackages.vue-language-server

      # Lua
      sumneko-lua-language-server

      # Go
      gopls
      delve

      # Yaml
      nodePackages.yaml-language-server

      # C#
      omnisharp-roslyn

      # Python
      nodePackages.pyright
      python310Packages.black
      # python310Packages.jedi-language-server

      # LaTeX
      # texlive.combined.scheme-full # Full LaTeX distribution
      sioyek # Preview
      texlab # LSP
      rubber
    ];
  };
}
