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
