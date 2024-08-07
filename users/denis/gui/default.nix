{
  pkgs,
  config,
  lib,
  osConfig ? null,
  ...
}: let
  condition = osConfig != null && osConfig.services.displayManager.sessionPackages != [];
in {
  imports = [
    ./gnome.nix
    ./plasma.nix
  ];

  config = lib.mkIf condition {
    home = {
      packages = with pkgs; [
        (discord.override {nss = nss_latest;})
        spotify
        # etcher
        # barrier
        input-leap
        megasync
        fsearch
        vlc
        qbittorrent
        flameshot
        okular
        # bottles
        # easyeffects
        mission-center

        # Pipewire gui
        coppwr
        helvum
        qpwgraph
        pwvucontrol

        # gwe

        (vimix-gtk-themes.override {
          themeVariants = ["doder"];
          colorVariants = ["dark"];
          sizeVariants = ["compact"];
          # tweaks = ["flat" "grey" "mix" "translucent"];
        })
        (vimix-icon-theme.override {
          colorVariants = ["Black"];
        })
        vimix-cursor-theme

        # dracula-theme
        # dracula-icon-theme

        remmina
        # rdesktop
        # libsForQt5.krdc

        gnome.gnome-boxes
        gparted
        autokey
        obs-studio
        piper
        protonvpn-gui
        mullvad-vpn
        # aawmtt

        libreoffice-qt
        hunspell
        hunspellDicts.en_US-large
        hunspellDicts.ru_RU
        hunspellDicts.tr_TR

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
        # jetbrains.webstorm
        # jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        # jetbrains.clion
        jetbrains.datagrip
        # jetbrains.goland
        # jetbrains.rust-rover

        # android-studio

        # blender
      ];
    };
  };
}
