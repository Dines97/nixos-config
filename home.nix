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
      # jupyter
      notebook
      # jupyterlab
      pandas
      numpy
      scikit-learn
      matplotlib

      (tensorflow-bin.override {cudaSupport = true;})
      # tensorflowWithCuda

      Keras

      gym
      pytorch
      torchvision
      pyglet
      seaborn

      opencv4
    ];

  python-with-packages = pkgs.python310.withPackages python-ml;

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
in {
  imports = [./modules/programs/hstr.nix];
  home = {
    username = "denis";
    stateVersion = "22.11";

    sessionVariables = {
      # I dont about should I create this variable by myself
      XDG_CONFIG_HOME = "$HOME/.config";

      # PYTHONPATH = "${python-with-packages}/${python-with-packages.sitePackages}";
      PAGER = "less";
      LESS = "-r --mouse";
      EDITOR = "nvim";
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
      # ROS
      # ros.gazebo

      cachix
      pciutils
      appimage-run
      gwe
      nix-info

      # Xmonad
      # dmenu
      # haskellPackages.xmobar
      # feh

      # Nix
      # unstable.rnix-lsp
      # unstable.nixpkgs-fmt
      unstable.nil
      unstable.alejandra
      unstable.statix

      # Neovim
      unstable.neovim
      xclip
      vale
      unstable.sumneko-lua-language-server
      unstable.gopls
      unstable.nodePackages.yaml-language-server
      unstable.omnisharp-roslyn
      unstable.nodePackages.prettier
      unstable.nodePackages.vue-language-server
      # vimPlugins.packer-nvim
      # unstable.python310Packages.jedi-language-server

      unstable.nodePackages.pyright
      unstable.python310Packages.black

      barrier
      megasync
      fsearch
      obs-studio
      vlc
      qbittorrent
      protonvpn-gui
      unstable.alacritty
      unstable.tmux
      unstable.wezterm
      gh
      libreoffice-fresh
      notepadqq
      flameshot
      unstable.teams
      spotify

      firefox
      dotnet-sdk # problems with unstable channel
      hstr
      exa
      bat
      ncdu
      xdotool
      htop
      ulauncher
      ulauncherDesktopItem
      wget
      jdk

      (discord.override {nss = nss_latest;})

      # Gnome
      # chrome-gnome-shell
      gnome.gnome-tweaks
      gnome.gnome-boxes
      gnome.gnome-keyring
      gnome.dconf-editor
      gnome.gnome-shell-extensions
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.x11-gestures
      # gnomeExtensions.app-icons-taskbar
      gnomeExtensions.appindicator
      # gnomeExtensions.appindicator
      # gparted
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
      # lens
      (callPackage ./pkgs/openlens {})
      k9s
      kubebuilder
      cue
      skaffold
      docker-compose

      minikube
      docker-machine-kvm2 # Minikube driver

      # JetBrains
      jetbrains.rider
      jetbrains.webstorm
      # jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.clion
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
        plugins = ["git"];
        theme = "robbyrussell";
      };
    };

    git = {
      enable = true;
      userName = "Denis Kaynar";
      userEmail = "kaynar.denis@gmail.com";
      extraConfig = {
        credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
      };
      lfs.enable = true;
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
