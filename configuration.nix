# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, home-manager, ... }:
let
  nodejs6_pkgs = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/12408341763b8f2f0f0a88001d9650313f6371d5.tar.gz";
    })
    { };

  nodejs6 = nodejs6_pkgs.nodejs-6_x;
in

let
  user-name = "denis";

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

  pycord_latest = p: p.callPackage ./pycord_latest.nix { };

  auradio = p: with p; with pkgs.python310Packages;[
    python-vlc
  ];

  python-bot = p: with p; with pkgs.python310Packages; [
    (pycord_latest p)
    sqlalchemy
    google-cloud-texttospeech
    setuptools
    psycopg2
    pylint
    langcodes
    language-data

    tkinter
  ];

  python-ml = p: with p; with pkgs.python310Packages; [
    # jupyter
    notebook
    # jupyterlab
    pandas
    numpy
    scikit-learn
    matplotlib
    discordpy

    (tensorflow-bin.override { cudaSupport = true; })
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
    categories = [ "GNOME" "GTK" "Utility" ];
  };

in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./cachix.nix

    ./hyprland.nix

  ];

  nixpkgs.overlays = [

    (self: super: {
      discord = super.discord.overrideAttrs (old: {
        version = "0.0.21";
        src = super.fetchurl {
          url = "https://dl.discordapp.net/apps/linux/0.0.21/discord-0.0.21.tar.gz";
          # sha256 = lib.fakeSha256;
          sha256 = "sha256-KDKUssPRrs/D10s5GhJ23hctatQmyqd27xS9nU7iNaM=";
        };
      });
    })
    #
    # (self: super: {
    #   sl = super.sl.overrideAttrs (old: {
    #     src = super.fetchFromGitHub {
    #       owner = "mtoyoda";
    #       repo = "sl";
    #       rev = "923e7d7ebc5c1f009755bdeb789ac25658ccce03";
    #       # sha256 = lib.fakeSha256;
    #       sha256 = "173gxk0ymiw94glyjzjizp8bv8g72gwkjhacigd1an09jshdrjb5";
    #     };
    #   });
    # })
    #
    # (self: super: {
    #   neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
    #     version = "nightly";
    #     src = super.fetchFromGitHub {
    #       owner = "neovim";
    #       repo = "neovim";
    #       rev = "nightly";
    #       sha256 = "sha256-gMPbe//zu8lxGgMy1C5o5N/YYYM8B26cs3H3F2rgFTo=";
    #     };
    #   });
    # })

  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome;[
    epiphany
    gnome-terminal
  ]);

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_testing;

  boot.supportedFilesystems = [ "ntfs" ];

  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  hardware.nvidia.prime = {
    offload.enable = true;
    # sync.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:2:0:0";
  };

  # hardware.opengl = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     intel-media-driver # LIBVA_DRIVER_NAME=iHD
  #     vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
  #     vaapiVdpau
  #     libvdpau-va-gl
  #     # libGL
  #     mesa.drivers
  #   ];
  # };

  services.flatpak.enable = true;
  services.xserver.enable = true;

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.gnome.chrome-gnome-shell.enable = true;

  # services.xserver.windowManager.i3 = {
  #   enable = true;
  #   package = pkgs.i3-gaps;
  # };

  services.xserver.windowManager.awesome.enable = true;

  # services.xserver.windowManager.xmonad = {
  #   enable = true;
  #   enableContribAndExtras = true;
  #   extraPackages = haskellPackages: [
  #     # haskellPackages.xmonad-wallpaper
  #   ];
  # };

  # programs.hyprland.enable = true;
  # programs.hyprland.package = unstable.hyprland;
  #
  # programs.sway.enable = true;
  # programs.sway.extraOptions = [
  #   "--verbose"
  #   "--debug"
  #   "--unsupported-gpu"
  # ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.firefox.enableGnomeExtensions = true;

  security.sudo.configFile = ''
    ${user-name} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/podman
  '';

  environment.shells = [ pkgs.zsh ];

  users.users.${user-name} = {
    isNormalUser = true;
    home = "/home/${user-name}";
    description = "Denis Kaynar";
    extraGroups = [ "wheel" "networkmanager" "docker" "podman" ];
    shell = pkgs.zsh;
    useDefaultShell = false;
  };

  home-manager.users.${user-name} = { pkgs, ... }: {

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

      # Nix
      unstable.rnix-lsp
      unstable.nixpkgs-fmt

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

      # Gnome
      # chrome-gnome-shell
      gnome.gnome-tweaks
      gnome.gnome-boxes
      gnome.gnome-keyring
      gnome.dconf-editor
      gnome.gnome-shell-extensions
      # gnomeExtensions.tray-icons-reloaded
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
      nodejs6
      nodePackages.pnpm

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
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };

    programs.git = {
      enable = true;
      userName = "Denis Kaynar";
      userEmail = "kaynar.denis@gmail.com";
      extraConfig = {
        credential.helper = "${ pkgs.git.override { withLibsecret = true; } }/bin/git-credential-libsecret";
      };
    };

    programs.go.enable = true;

  };

  # programs.partition-manager.enable = true;

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  # sound.enable = false;
  hardware.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      # enableNvidia = true;
    };

    # podman = {
    #   enable = true;
    #   enableNvidia = true;
    #   dockerCompat = true;
    #   dockerSocket.enable = true;
    # };
  };

  networking = {
    hostName = "Denis-N";
    extraHosts = ''
      192.168.49.2 argocd.testing.com jaeger.testing.com kiali.testing.com db.testing.com
      172.18.0.2 echo.com
    '';
    networkmanager.enable = true;

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  services.samba = {
    enable = true;
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      browseable = yes
    '';
    shares = {
      public = {
        path = "/home/${user-name}/shared";
        browseable = "yes";
        "guest ok" = "yes";

      };
    };
  };

  services.avahi = {
    nssmdns = true;
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us, ru";
    # xkbOptions = "grp:alt_shift_toggle";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  fonts.fonts = with pkgs; [
    liberation_ttf
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" "FiraCode" ];
    })
  ];

  environment.variables.JAVA_HOME = "${pkgs.jdk}/lib/openjdk";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    (discord.override { nss = nss_latest; })

    linux-pam
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
    jdk
    # jdk11
    # conda

    dmenu
    haskellPackages.xmobar
    feh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
