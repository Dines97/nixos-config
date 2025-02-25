{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    kulala = {
      enable = true;
      lazyLoad = {
        enable = false;
      };
      settings = {
        global_keymaps = true;
      };
    };

    presence-nvim = {
      enable = true;
    };

    rest = {
      enable = true;
      enableTelescope = true;
    };

    # lazy = {
    #   enable = true;
    #   plugins = [];
    # };
  };
}

