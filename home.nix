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
  imports = [./modules/programs/hstr.nix ./modules/programs/tmux.nix];

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

    sessionVariables = {
      # I dont about should I create this variable by myself
      XDG_CONFIG_HOME = "$HOME/.config";

      # PYTHONPATH = "${python-with-packages}/${python-with-packages.sitePackages}";
      PAGER = "less";
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
      vlc
      qbittorrent
      protonvpn-gui
      alacritty-launch
      unstable.wezterm
      gh
      # libreoffice-fresh
      notepadqq
      flameshot
      teams
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
      # (callPackage ./pkgs/openlens {})
      # (callPackage ./pkgs/openlens-bin {})
      (discord.override {nss = nss_latest;})
      k9s
      kubebuilder
      cue
      skaffold
      docker-compose

      minikube
      docker-machine-kvm2 # Minikube driver

      # JetBrains
      # jetbrains.rider
      # jetbrains.webstorm
      # jetbrains.idea-ultimate
      # jetbrains.pycharm-professional
      # jetbrains.clion
      # jetbrains.goland

      # JavaScript
      nodejs-18_x
      # (nodejs6.override { enableNpm = false; })
      # nodejs6
      # nodePackages.pnpm

      # Python
      #python-with-packages
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

    tmux = {
      enable = true;
      enableMouse = true;
      keyMode = "vi";
      terminal = "xterm-256color";
      historyLimit = 5000;
      clock24 = true;
      extraConfig = builtins.readFile ./conf/tmux.conf;
      package = pkgs.unstable.tmux;
      plugins = with pkgs.unstable; [
        tmuxPlugins.sensible
        tmuxPlugins.yank
      ];
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

    alacritty = {
      enable = true;
      package = pkgs.unstable.alacritty;
      settings = {
        draw_bold_text_with_bright_colors = false;
        shell = {
          program = "/bin/sh";
          args = ["-l" "-c" "tmux attach || tmux"];
        };
        window = {
          opacity = 0.9;
          dimensions = {
            columns = 140;
            lines = 30;
          };
        };
        font = {
          builtin_box_drawing = true;
          size = 13.0;
          normal = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold Italic";
          };
        };
      };
    };

    neovim = {
      enable = true;
      package = pkgs.unstable.neovim-unwrapped;
      defaultEditor = true;

      extraPackages = with pkgs; [
        # Nix
        # unstable.rnix-lsp
        # unstable.nixpkgs-fmt
        unstable.nil
        unstable.alejandra
        unstable.statix

        # Neovim
        xclip
        vale
        unstable.sumneko-lua-language-server
        unstable.gopls
        unstable.nodePackages.yaml-language-server
        unstable.omnisharp-roslyn
        unstable.nodePackages.prettier
        unstable.nodePackages.vue-language-server
        # unstable.python310Packages.jedi-language-server

        unstable.nodePackages.pyright
        unstable.python310Packages.black
      ];
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
