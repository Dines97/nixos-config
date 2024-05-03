{
  pkgs,
  config,
  lib,
  osConfig ? null,
  ...
}: {
  config = lib.mkIf (osConfig != null && osConfig.services.xserver.desktopManager.plasma5.enable) {
    home = {
      packages = with pkgs; [
        kate
        ark
        libsForQt5.kwalletmanager
        partition-manager
      ];
    };
  };
}
