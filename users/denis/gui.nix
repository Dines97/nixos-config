{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}: {
  # wayland = {
  #   windowManager = {
  #     hyprland = {
  #       enable = true;
  #       systemd.enable = true;
  #       xwayland.enable = true;
  #       # enableNvidiaPatches = true;
  #
  #       settings = {
  #         "$mainMod" = "SUPER";
  #
  #         "$terminal" = "alacritty";
  #
  #         bind = "$mainMod, Q, exec, $terminal";
  #       };
  #     };
  #   };
  # };

  home = {
    packages = with pkgs;
      lib.optionals (osConfig.services.xserver.displayManager.sessionPackages != []) [
        (discord.override {nss = nss_latest;})
        spotify
        etcher
        # barrier
        input-leap
        megasync
        fsearch
        vlc
        qbittorrent
        flameshot
        okular
        # gwe

        vimix-gtk-themes
        vimix-icon-theme

        remmina
        # rdesktop
        # libsForQt5.krdc

        gnome.gnome-boxes
        gparted
        autokey
        obs-studio
        piper
        protonvpn-gui
        # aawmtt
        libreoffice-fresh
        hunspell
        hunspellDicts.uk_UA
        hunspellDicts.th_TH

        thunderbird
        notepadqq

        # (retroarch.override {
        #   cores = with libretro; [
        #     dolphin
        #     ppsspp
        #     pcsx2
        #     fbneo
        #     # mame # NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM
        #     snes9x
        #     mesen
        #     mgba
        #   ];
        # })

        # retroarchFull

        openlens

        # JetBrains
        jetbrains.rider
        jetbrains.webstorm
        jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        jetbrains.clion
        jetbrains.datagrip
        # jetbrains.goland
        # jetbrains.rust-rover

        android-studio

        # blender
      ]
      # Gnome
      ++ lib.optionals (osConfig.services.xserver.desktopManager.gnome.enable) [
        gnome.gnome-tweaks
        gnome.gnome-keyring
        gnome.dconf-editor

        gnomeExtensions.app-icons-taskbar
        gnomeExtensions.appindicator
        gnomeExtensions.auto-select-headset
        gnomeExtensions.user-themes

        # gnomeExtensions.tray-icons-reloaded
        gnomeExtensions.x11-gestures
        gnomeExtensions.remove-alttab-delay-v2
        # gnomeExtensions.gamemode-indicator-in-system-settings
        # gnomeExtensions.caffeine
      ]
      # KDE
      ++ lib.optionals (osConfig.services.xserver.desktopManager.plasma5.enable) [
        kate
        ark
        libsForQt5.kwalletmanager
        partition-manager
      ];
  };
}
