{
  pkgs,
  lib,
  config,
  ...
}: let
  user-name = "denis";
in {
  imports = [
    ./audio.nix
    ./boot.nix
    ./hardware.nix
    ./nix.nix
    ./programs.nix
    ./services.nix
    # ./specialisation.nix
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5aba8042-ca71-4a29-88f3-a77bb99f608f";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7349-70A0";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077" "defaults"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/ed980955-0361-4121-8d01-f8446687699d";}
  ];

  zramSwap = {
    enable = true;
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  # containers = {
  #   recursive = {
  #     config = {
  #       config,
  #       pkgs,
  #       ...
  #     }: {
  #       containers = {
  #         recursive = {
  #           config = {
  #             config,
  #             pkgs,
  #             ...
  #           }: {
  #             containers = {
  #               recursive = {
  #                 config = {
  #                   config,
  #                   pkgs,
  #                   ...
  #                 }: {
  #                   containers = {
  #                     recursive = {
  #                       config = {
  #                         config,
  #                         pkgs,
  #                         ...
  #                       }: {
  #                         containers = {
  #                           recursive = {
  #                             config = {
  #                               config,
  #                               pkgs,
  #                               ...
  #                             }: {
  #                               services.postgresql.enable = true;
  #                             };
  #                           };
  #                         };
  #                       };
  #                     };
  #                   };
  #                 };
  #               };
  #             };
  #           };
  #         };
  #       };
  #     };
  #   };
  # };

  environment = {
    pathsToLink = [
      # Required for https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enableCompletion
      "/share/zsh"
      "/share/bash-completion"
    ];

    shells = [pkgs.zsh];

    gnome.excludePackages =
      (with pkgs; [
        gnome-tour
        epiphany
        gnome-terminal
      ])
      ++ (with pkgs.gnome; [
        gnome-shell-extensions
      ]);

    sessionVariables = {
      GTK_THEME = "vimix-dark-compact-doder";
    };
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
    # platformTheme = "gnome";
  };

  virtualisation = {
    docker = {
      enable = true;
      # enableNvidia = true;
      daemon.settings = {
        insecure-registries = ["5.178.111.177:5000"];
      };
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

  # xdg.portal = {
  #   wlr = {
  #     enable = true;
  #   };
  # };

  networking = {
    hostName = "Denis-N";
    usePredictableInterfaceNames = true;
    useDHCP = lib.mkDefault true;
    extraHosts = ''
      185.254.30.209 kubernetes.fridge.io
    '';
    networkmanager.enable = true;
    wireless.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"

      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        24800 # Barrier server port
        5357 # wsdd
      ];
      allowedUDPPorts = [
        3702 #wsdd
      ];
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
