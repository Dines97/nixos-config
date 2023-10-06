# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: let
  user-name = "denis";
in {
  environment = {
    shells = [pkgs.zsh];

    variables = {
      JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
      # GTK_THEME = "Vimix-dark-doder";
    };

    gnome.excludePackages =
      (with pkgs; [
        gnome-tour
      ])
      ++ (with pkgs.gnome; [
        epiphany
        gnome-terminal
        gnome-shell-extensions
      ]);
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = ["root" "@users"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config = {
      firefox.enableGnomeExtensions = true;
      permittedInsecurePackages = [
        "electron-12.2.3" # For etcher
      ];
      packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
      };
    };
  };

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = ["ntfs" "exfat"];

    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    # kernelPackages = pkgs.linuxKernel.packages.linux_testing;

    # plymouth = {
    #   enable = true;
    #   theme = "breeze";
    # };
    # initrd.systemd.enable = true;
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };

  programs = {
    ssh = {
      setXAuthLocation = true;
      forwardX11 = true;
    };

    zsh.enable = true;
    wireshark.enable = true;
  };

  # programs.sway.enable = true;
  # programs.sway.extraOptions = [
  #   "--verbose"
  #   "--debug"
  #   "--unsupported-gpu"
  # ];

  security = {
    sudo = {
      extraRules = [
        {
          users = ["${user-name}"];
          commands = [
            {
              command = "/run/current-system/sw/bin/podman";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };

    # rtkit is optional but recommended
    rtkit.enable = true;
  };

  users.users.${user-name} = {
    isNormalUser = true;
    home = "/home/${user-name}";
    description = "Denis Kaynar";
    extraGroups = ["wheel" "networkmanager" "docker" "podman" "libvirtd"];
    shell = pkgs.zsh;
    useDefaultShell = false;
  };

  # programs.partition-manager.enable = true;

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      # enableNvidia = true;
      daemon.settings = {
        insecure-registries = ["185.254.30.209:5000"];
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

  networking = {
    hostName = "Denis-N";
    extraHosts = ''
      185.254.30.209 kubernetes.fridge.io
    '';
    networkmanager.enable = true;

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

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  fonts.fonts = with pkgs; [
    # google-fonts
    (nerdfonts.override {
      fonts = ["JetBrainsMono" "FiraCode"];
    })
  ];

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
  system.stateVersion = "23.05"; # Did you read the comment?
}
