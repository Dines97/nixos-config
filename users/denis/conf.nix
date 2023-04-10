{
  config,
  pkgs,
  lib,
  ...
}: let
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

    packages = with pkgs; [
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
      dotnet-sdk_7 # problems with unstable channel
      hstr
      ripgrep
      exa
      bat
      ncdu
      xdotool
      htop
      ulauncher
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
      # jetbrains.pycharm-professional
      # jetbrains.clion
      # jetbrains.goland

      # openjdk11

      # Python
      conda

      # C/C++
      gnumake
      # gcc

      # Rust
      cargo

      # Haskell
      cabal-install
      ghc
      # haskell-language-server
      haskellPackages.haskell-language-server

      # Flutter
      flutter
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

    git = {
      enable = true;
      userName = "Denis Kaynar";
      userEmail = "kaynar.denis@gmail.com";
      extraConfig = {
        credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
        init.defaultBranch = "master";
      };
      lfs.enable = true;
      ignores = lib.splitString "\n" (builtins.readFile (builtins.fetchurl {
        url = "https://www.toptal.com/developers/gitignore/api/linux,vim,jetbrains,jetbrains+all,jetbrains+iml";
        name = "gitignore";
        sha256 = "sha256:0qdb55njabpnajqfvkvc40lkzl75pydav0i8yb6w8vcskbz0p9dw";
      }));
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
