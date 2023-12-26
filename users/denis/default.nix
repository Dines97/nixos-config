{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}: let
  my-python-packages = ps:
    with ps; [
      nextcord
      sqlalchemy
      google-cloud-texttospeech
      setuptools
      psycopg2

      pandas
      requests
      # other python packages
      fastapi
      uvicorn

      asgiref
      async-timeout
      certifi
      charset-normalizer
      click
      django
      idna
      importlib-metadata
      pysocks
      python-dotenv
      redis
      six
      spotipy
      sqlparse
      typing-extensions
      urllib3
      zipp
    ];

  alacritty-launch =
    pkgs.writeScriptBin "alacritty-launch"
    ''
       xid=$(${pkgs.xdotool}/bin/xdotool search --class Alacritty)

       if [ -z ''${xid} ]
       then
       ${pkgs.alacritty}/bin/alacritty
       else
      ${pkgs.xdotool}/bin/xdotool windowactivate ''${xid}
       fi
    '';
in {
  imports = [
    ./programs
  ];

  # dconf = {
  #   settings = {
  #     "org/gnome/desktop/input-sources" = {
  #       xkb-options = [
  #         "grp:alt_shift_toggle"
  #         "caps:none"
  #       ];
  #     };
  #   };
  # };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "alacritty";
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
    };
  };

  home = {
    username = "denis";
    stateVersion = "23.11";

    sessionVariables = {
      PAGER = "less";
      EDITOR = "nvim";
      LESS = "-r --mouse";
      GOPATH = "$HOME/go";

      DOTNET_CLI_UI_LANGUAGE = "en";
      LANG = "en_US.UTF-8";
    };

    sessionPath = [
      "$HOME/.krew/bin"
    ];

    shellAliases = {
      o = "xdg-open";
      gs = "git status";
      gt = "git log --all --decorate --oneline --graph";
      reset = "clear; tmux clear-history";
      ls = "eza";
      ll = "eza --long --all --header --time-style=long-iso --git --icons --group-directories-first --group -b";
      cat = "bat";
      nixrebuild = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch";

      nconf = "nvim $HOME/.config/nvim/";
      nixconf = "cd /etc/nixos && nvim /etc/nixos/";
      iconf = "nvim $HOME/.config/i3/";
      aconf = "nvim $HOME/.config/awesome/";
      hconf = "nvim $HOME/.config/hypr/";
    };

    packages = with pkgs;
      [
        # NixOS
        cachix
        pciutils
        appimage-run
        nix-info
        nix-index
      ]
      ++ [
        # Work
        openconnect
        azure-cli
        infracost
      ]
      ++ [
        # DevOps

        # k8s
        kubectl
        kubernetes-helm
        kube3d
        kind
        k9s
        kubebuilder
        cue
        skaffold

        docker-compose
        terraform
        postgresql

        vagrant
      ]
      ++ [
        (ansible.override {windowsSupport = true;})

        # Xmonad
        # haskellPackages.xmobar
        # feh

        (pkgs.python3.withPackages my-python-packages)

        gnumake
        ventoy-full
        xsel # tmux-yank required dependency

        dotnet-sdk_7
        hstr
        ripgrep
        # exa # unmaintained
        eza
        bat
        ncdu
        xdotool
        htop
        wget
        (openjdk17.override {enableJavaFX = true;})
        openssl
        git-credential-manager
        # gnupg
        # pinentry

        minikube
        docker-machine-kvm2 # Minikube driver

        # openjdk11

        # Python
        conda

        # C/C++
        # gnumake
        gcc # Required for clion
        gdb

        # Rust
        cargo

        # Haskell
        cabal-install
        ghc
        # haskell-language-server
        haskellPackages.haskell-language-server

        # JavaScript
        bun
        nodejs_20
        typescript # For volar in neovim to use

        # Flutter
        flutter
      ]
      ++ lib.optionals (osConfig.services.xserver.displayManager.sessionPackages != []) [
        spotify
        etcher
        # barrier
        input-leap

        remmina
        rdesktop
        libsForQt5.krdc

        gnome.gnome-boxes
        gparted
        flameshot
        (discord.override {nss = nss_latest;})
        autokey
        megasync
        fsearch
        obs-studio
        piper
        vlc
        qbittorrent
        protonvpn-gui
        alacritty-launch
        aawmtt
        libreoffice-fresh
        hunspell
        hunspellDicts.uk_UA
        hunspellDicts.th_TH

        vimix-gtk-themes
        vimix-icon-theme

        thunderbird
        notepadqq
        teams-for-linux

        (retroarch.override {
          cores = with libretro; [
            dolphin
            ppsspp
            pcsx2
            fbneo
            # mame # NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM
            snes9x
            mesen
            mgba
          ];
        })

        # JetBrains
        jetbrains.rider
        jetbrains.webstorm
        # jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        # jetbrains.clion
        jetbrains.datagrip
        # jetbrains.goland

        android-studio
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
