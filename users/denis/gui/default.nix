{
  pkgs,
  config,
  lib,
  osConfig ? null,
  inputs,
  ...
}: let
  condition = osConfig != null && osConfig.services.displayManager.sessionPackages != [];
in {
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./plasma.nix
  ];

  config = lib.mkIf condition {
    xdg = {
      autostart = {
        enable = true;
        entries = [
          "${pkgs.discord}/share/applications/discord.desktop"
          "${pkgs.flameshot}/share/applications/org.flameshot.Flameshot.desktop"
          "${pkgs.input-leap}/share/applications/io.github.input_leap.InputLeap.desktop"
          "${pkgs.spotify}/share/applications/spotify.desktop"
          "${pkgs.teams-for-linux}/share/applications/teams-for-linux.desktop"
        ];
      };
    };

    home = {
      packages = with pkgs; [
        (discord.override {nss = nss_latest;})
        vesktop
        spotify
        nicotine-plus
        # etcher
        # barrier
        input-leap
        megasync
        fsearch
        vlc
        qbittorrent
        tor-browser
        flameshot
        kdePackages.okular
        # bottles
        easyeffects
        # mission-center
        gimp

        # Pipewire gui
        coppwr
        helvum
        qpwgraph
        pwvucontrol

        waycheck
        bustle

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
        vimix-cursors

        # dracula-theme
        # dracula-icon-theme

        remmina
        # rdesktop
        # libsForQt5.krdc

        gnome-boxes
        gparted
        autokey
        obs-studio
        piper
        # mozillavpn
        protonvpn-gui
        protonvpn-cli
        # cloudflare-warp
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

        lens

        # JetBrains
        jetbrains.rider
        # jetbrains.webstorm
        # jetbrains.idea-ultimate
        # jetbrains.pycharm-professional
        # jetbrains.clion
        # jetbrains.datagrip
        # jetbrains.goland
        # jetbrains.rust-rover

        # android-studio

        # blender
      ];
    };
  };
}

