{
  config,
  pkgs,
  unstable,
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
      discordpy

      (tensorflow-bin.override {cudaSupport = true;})
      # tensorflowWithCuda

      Keras

      gym
      pytorch
      torchvision
      pyglet
      seaborn
    ];

  python-with-packages = pkgs.python310.withPackages python-bot;

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
  home.username = "denis";
  home.stateVersion = "22.05";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    # I dont about should I create this variable by myself
    XDG_CONFIG_HOME = "$HOME/.config";

    # PYTHONPATH = "${python-with-packages}/${python-with-packages.sitePackages}";
    PAGER = "less";
    LESS = "-r --mouse";
    EDITOR = "nvim";
    GOPATH = "$HOME/go";
    PNPM_HOME = "$HOME/pnpm";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "/home/denis/.local/share/pnpm/global/5/node_modules/.bin"
    "$HOME/pnpm"

    # Not sure maybe it wrong to include it here
    "${python-with-packages}/bin"
  ];

  home.shellAliases = {
    o = "xdg-open";
    gs = "git status";
    gt = "git log --all --decorate --oneline --graph";
    reset = "clear; tmux clear-history";
    ls = "exa";
    ll = "exa --long --all --header --time-style=long-iso --git --icons --group-directories-first --group -b";
    # ll = "ls -avlhF --group-directories-first";

    nconf = "nvim $HOME/.config/nvim/";
    nixconf = "sudo -E nvim /etc/nixos/";
    iconf = "nvim $HOME/.config/i3/";
    aconf = "nvim $HOME/.config/awesome/";
  };

  # programs.vscode.enable = true;
  # programs.vscode.package = pkgs.vscode-fhsWithPackages (ps: with ps; [ gcc gdb gnumake cmake ]);

  home.packages = with pkgs; [
    cachix
    pciutils
    appimage-run
    gwe

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
    teams

    spotify
    firefox
    dotnet-sdk # problems with unstable channel
    hstr
    exa
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
    kubernetes-helm
    postgresql
    minikube
    kube3d
    kind
    lens
    k9s
    kubebuilder
    cue
    skaffold
    docker-compose

    # JetBrains
    jetbrains.rider
    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.clion
    jetbrains.goland

    # JavaScript
    # (nodejs6.override { enableNpm = false; })
    # nodejs6
    # nodePackages.pnpm

    # Python
    python-with-packages
    python2

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

  # services.barrier.client = {
  #   enable = true;
  #   enableCrypto = true;
  #   enableDragDrop = false;
  #   name = "Denis-N";
  #   server = "Denis-PC";
  # };

  programs.zsh = {
    enable = true;
    history = {
      share = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    initExtra = ''
      # HSTR configuration - add this to ~/.zshrc
      alias hh=hstr                    # hh to be alias for hstr
      setopt histignorespace           # skip cmds w/ leading space from history
      export HSTR_CONFIG=hicolor       # get more colors
      bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
    '';

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    userName = "Denis Kaynar";
    userEmail = "kaynar.denis@gmail.com";
    extraConfig = {
      credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
    };
  };

  # programs.hstr = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  programs.go.enable = true;
}
