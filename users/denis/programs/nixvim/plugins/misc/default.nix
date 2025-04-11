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
    };

    presence-nvim = {
      enable = true;
    };

    rest = {
      enable = true;
      enableTelescope = true;
    };

    snacks = {
      enable = true;
      settings = {
        picker = {};
      };
    };

    # lazy = {
    #   enable = true;
    #   plugins = [];
    # };
  };
}

