{
  lib,
  pkgs,
  config,
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
  home = {
    username = "denis";
    stateVersion = "23.05";

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
      nixrebuild = "sudo nix flake update /etc/nixos && sudo nixos-rebuild switch";

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
        # cue
        skaffold

        docker-compose
        terraform
        postgresql
      ]
      ++ [
        (ansible.override {windowsSupport = true;})
        preload

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
        firefox
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

  programs = {
    zsh = {
      enable = true;
      # enableSyntaxHighlighting = true;
      history = {
        share = true;
        ignoreDups = true;
        expireDuplicatesFirst = true;
      };

      localVariables = {
        ZSH_TMUX_AUTOSTART = true;
        ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
      };

      oh-my-zsh = {
        enable = true;
        plugins = ["git" "kubectx" "tmux"];
        theme = "robbyrussell";
      };
      zplug = {
        enable = true;
        plugins = [
          {
            name = "zsh-users/zsh-syntax-highlighting";
          }
        ];
      };
    };
    rofi = {
      enable = true;
      theme = "Arc-Dark";
      extraConfig = {
        show-icons = true;
        kb-cancel = "Alt+space,Escape";
      };
    };

    git = {
      enable = true;
      userName = "Denis Kaynar";
      userEmail = "kaynar.denis@gmail.com";
      extraConfig = {
        credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
        init.defaultBranch = "master";
        core.autocrlf = "input";
      };
      lfs.enable = true;
      ignores = lib.splitString "\n" (builtins.readFile (builtins.fetchurl {
        url = "https://www.toptal.com/developers/gitignore/api/linux,windows,macos,jetbrains,jetbrains+all,jetbrains+iml,vim,visualstudio,visualstudiocode,rider,intellij,intellij+all,intellij+iml,pycharm,pycharm+all,pycharm+iml";
        name = "gitignore";
        sha256 = "sha256:00qj9fyhg9baajrrqd4hnr906wrzlvgk0vdphyfn1l02napdldwr";
      }));
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      # nix-direnv.enable = true;
    };

    sioyek = {
      enable = true;
      config = {
        dark_mode_contrast = "0.7";
        page_separator_width = "8";
        page_separator_color = "0.5 0.5 0.5";
        custom_background_color = "0.81 0.81 0.75";
        custom_text_color = "0.09 0.09 0.09";
      };
    };

    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };

    go.enable = true;

    hstr = {
      enable = true;
      enableZshIntegration = true;
    };

    # vscode = {
    #   enable = true;
    #   package = pkgs.vscode-fhsWithPackages (ps: with ps; [gcc gdb gnumake cmake]);
    # };
  };
}
