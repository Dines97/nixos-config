{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./plugins
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    # package = pkgs.neovim-nightly;
    # defaultEditor = true;

    extraLuaConfig = builtins.readFile ./init.lua;

    plugins = with pkgs.vimUtils;
    with pkgs.vimPlugins; [
      nvim-nio # A library for asynchronous IO in Neovim
      nvim-spectre
      # {
      #   plugin = filetype-nvim;
      #   type = "lua";
      #   config = builtins.readFile ./plugins/filetype.lua;
      # }

      vim-helm # Helm lsp plugin

      plenary-nvim # Required for most of the plugins
      dressing-nvim # vim.ui interface improvement

      nvim-navic # Current code context
      {
        plugin = indent-blankline-nvim; # Indention line
        type = "lua";
        config = builtins.readFile ./plugins/indent-blankline.lua;
      }
      {
        plugin = gitsigns-nvim; # Show git signs in sidebar
        type = "lua";
        config = builtins.readFile ./plugins/gitsigns.lua;
      }
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
        config = builtins.readFile ./plugins/neoclip.lua; # Persistent need be activated separately
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
        config = builtins.readFile ./plugins/fidget.lua;
      }
      {
        plugin = todo-comments-nvim; # Comment highlighting
        type = "lua";
        config = "require('todo-comments').setup()";
      }
      {
        plugin = mini-nvim; # Collection of small modules
        type = "lua";
        config = builtins.readFile ./plugins/mini.lua; # Each of module need to be activated separately
      }
      hologram-nvim
      {
        plugin = pets-nvim;
        type = "lua";
        config = "require('pets').setup()";
      }
      {
        plugin = tmux-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/tmux.lua;
      }

      lsp-status-nvim

      nui-nvim
      {
        plugin = nvim-notify;
        type = "lua";
        config = builtins.readFile ./plugins/notify.lua;
      }
      {
        plugin = onedark-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/onedark.lua;
      }
      {
        plugin = neodev-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/neodev.lua;
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/trouble.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/which_key.lua;
      }
      {
        plugin = legendary-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/legendary.lua;
      }
    ];

    extraPackages = with pkgs; [
      git # For git related plugins

      discord # Just for presence

      sqlite # Required for neoclip

      # Mix
      xclip
      vale
    ];
  };
}
