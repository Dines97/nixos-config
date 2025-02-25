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

    # lazy = {
    #   enable = true;
    #   plugins = [];
    # };
  };
}

