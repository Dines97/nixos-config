{
  pkgs,
  config,
  lib,
  osConfig ? null,
  ...
}: {
  config = lib.mkIf (osConfig != null && osConfig.services.desktopManager.plasma6.enable) {
    qt = {
      enable = true;
      platformTheme = {
        name = "kde6";
      };

      # style = {
      #   name = "kvantum";
      # };
      # style = "adwaita-dark";
    };
    home = {
      packages = with pkgs; [
        kdePackages.kalk
        kdePackages.partitionmanager
        kdePackages.kate
        # klassy
        # kdePackages.kwalletmanager
      ];
    };
  };
}

