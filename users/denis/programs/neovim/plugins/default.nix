{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./cmp
    ./dap
    ./languages
    ./lsp
    ./multiplexer
    ./telescope
    ./treesitter
    ./ui
  ];

  programs.neovim = {
    plugins = with pkgs.vimUtils;
    with pkgs.vimPlugins; [
      nvim-nio # A library for asynchronous IO in Neovim
      nvim-spectre
      # {
      #   plugin = filetype-nvim;
      #   type = "lua";
      #   config = builtins.readFile ./filetype.lua;
      # }

      vim-helm # Helm lsp plugin

      plenary-nvim # Required for most of the plugins
      dressing-nvim # vim.ui interface improvement

      nvim-navic # Current code context
      {
        plugin = indent-blankline-nvim; # Indention line
        type = "lua";
        config = builtins.readFile ./indent-blankline.lua;
      }
      {
        plugin = gitsigns-nvim; # Show git signs in sidebar
        type = "lua";
        config = builtins.readFile ./gitsigns.lua;
      }

      # {
      #   plugin = presence-nvim; # Discord presence plugin
      #   type = "lua";
      #   config =
      #     # lua
      #     ''
      #       require('presence').setup({ enable_line_number = true })
      #     '';
      # }

      {
        plugin = comment-nvim; # Commenting plugin
        type = "lua";
        config = "require('Comment').setup()"; # Setup should be called for default keybindings
      }
      {
        plugin = fidget-nvim;
        type = "lua";
        config = builtins.readFile ./fidget.lua;
      }
      {
        plugin = todo-comments-nvim; # Comment highlighting
        type = "lua";
        config = "require('todo-comments').setup()";
      }
      {
        plugin = mini-nvim; # Collection of small modules
        type = "lua";
        config = builtins.readFile ./mini.lua; # Each of module need to be activated separately
      }
      hologram-nvim
      {
        plugin = pets-nvim;
        type = "lua";
        config = "require('pets').setup()";
      }

      lsp-status-nvim

      nui-nvim
      {
        plugin = nvim-notify;
        type = "lua";
        config = builtins.readFile ./notify.lua;
      }
      {
        plugin = onedark-nvim;
        type = "lua";
        config = builtins.readFile ./onedark.lua;
      }
      {
        plugin = neodev-nvim;
        type = "lua";
        config = builtins.readFile ./neodev.lua;
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = builtins.readFile ./trouble.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./which_key.lua;
      }
      {
        plugin = legendary-nvim;
        type = "lua";
        config = builtins.readFile ./legendary.lua;
      }
    ];

    extraPackages = with pkgs; [
      git # For git related plugins

      discord # Just for presence

      # Mix
      xclip
      vale
    ];
  };
}
