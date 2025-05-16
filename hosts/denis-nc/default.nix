{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./disk.nix
    ./hardware.nix
    ./nix.nix
    ./programs.nix
    ./services.nix
    # ./specialisation.nix
  ];

  # fileSystems = {
  #   "/" = {
  #     device = "/dev/disk/by-uuid/5aba8042-ca71-4a29-88f3-a77bb99f608f";
  #     fsType = "ext4";
  #   };
  #
  #   "/boot" = {
  #     device = "/dev/disk/by-uuid/7349-70A0";
  #     fsType = "vfat";
  #     options = ["fmask=0077" "dmask=0077" "defaults"];
  #   };
  # };

  # powerManagement = {
  #   # enable = true;
  #   cpuFreqGovernor = "performance";
  # };

  environment = {
    pathsToLink = [
      # Required for https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enableCompletion
      "/share/zsh"
      "/share/bash-completion"
    ];

    shells = [pkgs.zsh];

    gnome.excludePackages = with pkgs; [
      gnome-tour
      epiphany
      gnome-terminal
      gnome-shell-extensions
    ];

    sessionVariables = {
      GTK_THEME = "vimix-dark-compact-doder";
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      # enableNvidia = true;
    };

    podman = {
      enable = true;
      # enableNvidia = true;
      dockerCompat = false;
      dockerSocket.enable = false;
    };

    virtualbox.host.enable = true;

    libvirtd.enable = true;
  };

  users.extraGroups.vboxusers.members = ["denis"];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqJaPV/2jidFU9D9Xiz8NFt2dligI/yGLHJzbGuJuaLbfGQgbwIrKRn5JhT5zvPWtiRW2IXq/f3a/ZDvmunFGFTotr5bL9PgCTJxjJhXf/g7EDVEKV5qZBTmON3yRezlWDTbR2tJwuxt6rowcOqLNW/lljs53Iui0UpHjdyU1Plh390T4IdFl8BDzwiQPGDtJAbukjQWrCrTHEkql5stD9m5AOyANgxBzt6VEtGhFHh+o2iCChOBWvtjdvqRMIPk1PhEhpzdu55NLZ9l8KTT+sm10T+6h5/zdEviLITHbYRdzvTRrz2//SRRaKxweKMLXXsO9HHFwreLjviZTkU1ZYxAah8dxgH5/q4syUYQ8V77NVLMQ253/v09Itlp0lsXyld7bfVZ12yQtMMvRaIh0emg3JupPHoIySS0ye49Uynat3jtkYT1fJpr3/uZdzKBHrrJdw+/ZnziF/wE6VLlTkcGbk9tWOSuXagD35EVpzspk37C+Me5gOQq2p4IOawwM= root@Denis-N "
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/G+pCzalAw0XAwdE/M+8az+OkN3+MC6XCxrzY3wtYq root@Denis-N"
  ];

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    xdgOpenUsePortal = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  networking = {
    hostName = "Denis-NC";
    usePredictableInterfaceNames = true;

    networkmanager = {
      enable = true;
      # dns = "none";
    };
    wireless.enable = true;

    useDHCP = false;
    dhcpcd.enable = false;
    # dhcpcd.extraConfig = "nohook resolv.conf";

    extraHosts = ''
    '';

    # nameservers = [
    #   "127.0.0.1"
    # ];

    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        24800 # Barrier server port
        5357 # wsdd
      ];
      allowedUDPPorts = [
        3702 # wsdd
        51820 # wireguard
        4242 # lan-mouse
        34197
      ];
      checkReversePath = false;
    };

    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MONETARY = "tr_TR.UTF-8";
      LC_PAPER = "tr_TR.UTF-8";
      LC_MEASUREMENT = "tr_TR.UTF-8";
      LC_TIME = "tr_TR.UTF-8";
      LC_NUMERIC = "tr_TR.UTF-8";
    };
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

