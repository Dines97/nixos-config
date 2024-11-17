{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./colorschemes
    # ./modules
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    withNodeJs = true;
    withRuby = true;

    luaLoader = {
      enable = true;
    };

    # extraConfigLuaPre = ''
    #   vim.keymap.set("", "\\", "<Nop>", { noremap = true, silent = true })
    # '';

    extraConfigLuaPost = ''
      vim.api.nvim_command("redraw!")
      vim.cmd("redraw!")
    '';

    extraPackages = with pkgs; [
      # TODO: Check if luasnip works
      luajitPackages.jsregexp

      # For telescope
      ripgrep
      fd
      # TODO: Find a way to remove it without breaking presence plugin
      discord
    ];

    performance = {
      byteCompileLua = {
        enable = false;
      };
    };

    clipboard = {
      providers = {
        wl-copy = {
          enable = true;
        };
        xclip = {
          enable = true;
        };
        xsel = {
          enable = true;
        };
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    opts = {
      timeout = true;
      timeoutlen = 0;
      # timeoutlen = 300;

      mouse = "a";
      number = true;
      relativenumber = true;
      wrap = false;

      tabstop = 2;
      softtabstop = 2;
      shiftround = true;
      shiftwidth = 2;
      expandtab = true;
      textwidth = 100;

      undofile = true;

      # spelllang = "en_us";
      # spell = true;
    };
  };
}

