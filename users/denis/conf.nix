{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  my-python-packages = ps:
    with ps; [
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
      PNPM_HOME = "$HOME/pnpm";

      DOTNET_CLI_UI_LANGUAGE = "en";
      LANG = "en_US.UTF-8";
    };

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

    packages = with pkgs;
      lib.mkMerge [
        (lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable [
          gnome.gnome-tweaks
          gnome.gnome-keyring
          gnome.dconf-editor
          gnome.gnome-shell-extensions
          gnomeExtensions.tray-icons-reloaded
          gnomeExtensions.x11-gestures
          gnomeExtensions.app-icons-taskbar
          gnomeExtensions.appindicator
          gnomeExtensions.remove-alttab-delay-v2
          gnomeExtensions.caffeine
        ])
        (lib.mkIf (osConfig.services.xserver.displayManager.sessionPackages != []) [
          (retroarch.override {
            cores = with libretro; [
              dolphin
              ppsspp
              pcsx2
              fbneo
              mame
              snes9x
              mesen
              mgba
            ];
          })
        ])
        [
          preload

          cachix
          pciutils
          appimage-run
          # gwe
          nix-info

          # Xmonad
          # dmenu
          # haskellPackages.xmobar
          # feh

          (pkgs.python3.withPackages my-python-packages)

          barrier
          megasync
          fsearch
          obs-studio
          piper
          vlc
          gnumake
          qbittorrent
          protonvpn-gui
          alacritty-launch
          wezterm
          aawmtt
          ventoy-full
          libreoffice-fresh
          hunspell
          hunspellDicts.uk_UA
          hunspellDicts.th_TH
          notepadqq
          flameshot
          teams
          spotify
          (discord.override {nss = nss_latest;})
          etcher
          gnome.gnome-boxes
          gparted
          vimix-gtk-themes
          vimix-icon-theme

          firefox
          thunderbird
          autokey
          dotnet-sdk_7
          hstr
          ripgrep
          exa
          bat
          ncdu
          xdotool
          htop
          wget
          (openjdk17.override {enableJavaFX = true;})

          # KDE
          # kate
          # ark
          # libsForQt5.kwalletmanager
          # partition-manager

          # DevOps
          kubectl
          kubernetes-helm
          postgresql
          kube3d
          kind
          openlens
          k9s
          kubebuilder
          cue
          skaffold
          docker-compose
          terraform

          minikube
          docker-machine-kvm2 # Minikube driver

          # JetBrains
          jetbrains.rider
          # jetbrains.webstorm
          jetbrains.idea-ultimate
          jetbrains.pycharm-professional
          jetbrains.clion
          android-studio
          # jetbrains.goland

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
        ]
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
        plugins = ["git" "kubectx"] ++ lib.optional (osConfig.networking.hostName == "work") ["tmux"];
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
