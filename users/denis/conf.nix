{
  config,
  pkgs,
  ...
}: let
  python-bot = p:
    with p;
    with pkgs.python310Packages; [
      discordpy
      sqlalchemy
      google-cloud-texttospeech
      setuptools
      psycopg2
      pylint
      langcodes
      language-data
    ];

  python-ml = p:
    with p;
    with pkgs.python310Packages; [
      jupyter
      notebook
      # jupyterlab
      pandas
      numpy
      scikit-learn
      matplotlib

      (tensorflow-bin.override {cudaSupport = true;})
      keras

      gym
      pytorch
      torchvision
      pyglet
      seaborn

      opencv4
    ];

  gondola-bot-plus-panic-api = p:
    with p;
    with pkgs.python310Packages; [
      nextcord
      fastapi
      uvicorn
      setuptools
      beautifulsoup4
      jsonpickle
      sqlalchemy
      google-cloud-texttospeech
      psycopg2
      yt-dlp
    ];

  python-with-packages = pkgs.python310.withPackages gondola-bot-plus-panic-api;

  ulauncherDesktopItem = pkgs.makeDesktopItem {
    name = "Ulauncher";
    desktopName = "Ulauncher";
    icon = "ulauncher";
    exec = "ulauncher";
    comment = "Application launcher for Linux";
    categories = ["GNOME" "GTK" "Utility"];
  };

  # pycord_latest = p: p.callPackage ./pycord_latest.nix { };
  nodejs6_pkgs =
    import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/12408341763b8f2f0f0a88001d9650313f6371d5.tar.gz";
    })
    {};

  nodejs6 = nodejs6_pkgs.nodejs-6_x;

  alacritty-launch =
    pkgs.writeScriptBin "alacritty-launch"
    ''
       xid=$(${pkgs.xdotool}/bin/xdotool search --class Alacritty)

       if [ -z ''${xid} ]
       then
       ${pkgs.unstable.alacritty}/bin/alacritty
       else
      ${pkgs.xdotool}/bin/xdotool windowactivate ''${xid}
       fi
    '';
in {
  dconf.settings = {
    "org.gnome.desktop.input-sources" = {
      xkb-options = "['grp:alt_shift_toggle','caps:none']";
    };
    "org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0" = {
      binding = "<Control>Return";
      command = "${alacritty-launch}/bin/alacritty-launch";
      name = "Alacritty activate";
    };
  };

  home = {
    username = "denis";
    stateVersion = "22.11";

    pointerCursor = {
      package = pkgs.nordzy-cursor-theme;
      gtk.enable = true;
      x11.enable = true;
      name = "Nordzy-cursors";
    };

    sessionVariables = {
      # I dont about should I create this variable by myself
      XDG_CONFIG_HOME = "$HOME/.config";

      # PYTHONPATH = "${python-with-packages}/${python-with-packages.sitePackages}";
      PAGER = "less";
      EDITOR = "nvim";
      LESS = "-r --mouse";
      GOPATH = "$HOME/go";
      PNPM_HOME = "$HOME/pnpm";

      DOTNET_CLI_UI_LANGUAGE = "en";
      LANG = "en_US.UTF-8";
    };

    sessionPath = [
      "$HOME/.local/bin"
      "/home/denis/.local/share/pnpm/global/5/node_modules/.bin"
      "$HOME/pnpm"

      # Not sure maybe it wrong to include it here
      "${python-with-packages}/bin"
    ];

    shellAliases = {
      o = "xdg-open";
      gs = "git status";
      gt = "git log --all --decorate --oneline --graph";
      reset = "clear; tmux clear-history";
      ls = "exa";
      ll = "exa --long --all --header --time-style=long-iso --git --icons --group-directories-first --group -b";
      cat = "bat";
      nixrebuild = "sudo nix flake update /etc/nixos && sudo nixos-rebuild switch";

      nconf = "nvim $HOME/.config/nvim/";
      nixconf = "nvim /etc/nixos/";
      iconf = "nvim $HOME/.config/i3/";
      aconf = "nvim $HOME/.config/awesome/";
      hconf = "nvim $HOME/.config/hypr/";
    };

    packages = with pkgs; [
      (retroarch.override {
        cores = with libretro; [
          dolphin
        ];
      })

      # ROS
      # ros.gazebo

      cachix
      pciutils
      appimage-run
      # gwe
      nix-info

      # Xmonad
      # dmenu
      # haskellPackages.xmobar
      # feh

      barrier
      megasync
      fsearch
      obs-studio
      piper
      vlc
      qbittorrent
      protonvpn-gui
      alacritty-launch
      unstable.wezterm
      libreoffice-fresh
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.th_TH
      notepadqq
      flameshot
      unstable.teams
      spotify
      (discord.override {nss = unstable.nss_latest;})
      etcher

      unstable.firefox
      unstable.thunderbird
      autokey
      dotnet-sdk # problems with unstable channel
      hstr
      ripgrep
      exa
      bat
      ncdu
      xdotool
      htop
      ulauncher
      ulauncherDesktopItem
      wget
      jdk

      # Gnome
      # chrome-gnome-shell
      gnome.gnome-tweaks
      gnome.gnome-boxes
      gnome.gnome-keyring
      gnome.dconf-editor
      gnome.gnome-shell-extensions
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.x11-gestures
      gnomeExtensions.app-icons-taskbar
      gnomeExtensions.appindicator
      gnomeExtensions.remove-alttab-delay-v2
      gnomeExtensions.caffeine
      gparted
      vimix-gtk-themes
      vimix-icon-theme

      # KDE
      # kate
      # ark
      # libsForQt5.kwalletmanager
      # partition-manager

      # DevOps
      kubectl
      unstable.kubernetes-helm
      postgresql
      kube3d
      kind
      openlens
      k9s
      kubebuilder
      cue
      skaffold
      docker-compose

      minikube
      docker-machine-kvm2 # Minikube driver

      # JetBrains
      jetbrains.rider
      # jetbrains.webstorm
      # jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      # jetbrains.clion
      # jetbrains.goland

      # JavaScript
      nodejs-18_x
      # (nodejs6.override { enableNpm = false; })
      # nodejs6
      # nodePackages.pnpm

      # Python
      python-with-packages
      conda

      # C/C++
      cmake
      gnumake
      gcc

      # Rust
      cargo

      # Go
      unstable.delve

      # Haskell
      cabal-install
      ghc
      # haskell-language-server
      haskellPackages.haskell-language-server

      # Junk
      cmatrix
      neofetch
      sl
    ];
  };

  programs = {
    zsh = {
      enable = true;
      history = {
        share = true;
        ignoreDups = true;
        expireDuplicatesFirst = true;
      };

      oh-my-zsh = {
        enable = true;
        plugins = ["git" "kubectx"];
        theme = "robbyrussell";
      };
    };

    zellij = {
      enable = true;
      package = pkgs.unstable.zellij;
      settings = {
      };
    };

    git = {
      enable = true;
      userName = "Denis Kaynar";
      userEmail = "kaynar.denis@gmail.com";
      extraConfig = {
        credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
        init.defaultBranch = "master";
      };
      lfs.enable = true;
    };

    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };

    doom-emacs = {
      enable = true;
      doomPrivateDir = ./configs/doom.d;
      emacsPackage = pkgs.emacs-nox;
    };

    # emacs = {
    #   enable = true;
    #   package = pkgs.unstable.emacs;
    #   extraPackages = epkgs: [];
    # };

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