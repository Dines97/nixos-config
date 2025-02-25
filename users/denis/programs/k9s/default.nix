{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        ui = {
          enableMouse = true;
          logoless = true;
          reactive = true;
        };
      };
    };
  };
}

