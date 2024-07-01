{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./colorschemes
    ./keymaps
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    package = pkgs.neovim-unwrapped;

    withNodeJs = true;
    withRuby = true;

    luaLoader = {
      enable = true;
    };

    extraPackages = with pkgs; [
      # TODO: Check if luasnip works
      luajitPackages.jsregexp

      # For telescope
      ripgrep
      fd
    ];

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

    extraConfigLuaPre = ''
      local luasnip = require("luasnip")
      local notify = require('notify')
      local stages = require('notify.stages.static')('top_down')
      vim.notify = notify
    '';

    globals = {
      mapleader = " ";
    };

    opts = {
      timeout = true;
      timeoutlen = 300;

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

      spelllang = "en_us";
      spell = true;
    };
  };
}
