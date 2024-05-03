{
  pkgs,
  config,
  lib,
  osConfig ? null,
  ...
}: {
  config = lib.mkIf (osConfig != null && osConfig.services.xserver.desktopManager.gnome.enable) {
    home = {
      packages = with pkgs; [
        gnome.gnome-tweaks
        gnome.gnome-keyring
        gnome.dconf-editor

        gnomeExtensions.app-icons-taskbar
        gnomeExtensions.appindicator
        gnomeExtensions.auto-select-headset
        gnomeExtensions.user-themes

        # gnomeExtensions.tray-icons-reloaded
        gnomeExtensions.x11-gestures

        # TODO: Readd
        # gnomeExtensions.remove-alttab-delay-v2

        # gnomeExtensions.gamemode-indicator-in-system-settings
        # gnomeExtensions.caffeine
      ];
    };
  };
}
