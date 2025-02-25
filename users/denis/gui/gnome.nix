{
  pkgs,
  config,
  lib,
  osConfig ? null,
  ...
}: {
  # imports = [./dconf.nix];

  config = lib.mkIf (osConfig != null && osConfig.services.xserver.desktopManager.gnome.enable) {
    home = {
      packages = with pkgs; [
        gnome-tweaks
        gnome-keyring
        dconf-editor

        gnomeExtensions.app-icons-taskbar
        gnomeExtensions.appindicator
        gnomeExtensions.auto-select-headset
        gnomeExtensions.user-themes
        gnomeExtensions.x11-gestures

        # gnomeExtensions.tray-icons-reloaded

        # TODO: Readd
        # gnomeExtensions.remove-alttab-delay-fork

        # gnomeExtensions.gamemode-indicator-in-system-settings
        # gnomeExtensions.caffeine
      ];
    };
  };
}

