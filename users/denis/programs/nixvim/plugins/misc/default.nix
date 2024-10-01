{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    # presence-nvim = {
    #   enable = true;
    # };

    rest = {
      enable = true;
      enableTelescope = true;
    };
  };
}

