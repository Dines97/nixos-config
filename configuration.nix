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

    variables.JAVA_HOME = "${pkgs.jdk}/lib/openjdk";

    gnome.excludePackages =
      (with pkgs; [
        gnome-tour
      ])
      ++ (with pkgs.gnome; [
        epiphany
        gnome-terminal
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
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      firefox.enableGnomeExtensions = true;
      permittedInsecurePackages = [
        "electron-12.2.3" # For etcher
      ];
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

    # supportedFilesystems = ["ntfs"];

    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    # kernelPackages = pkgs.linuxKernel.packages.linux_testing;

    # plymouth = {
    #   enable = true;
    #   theme = "breeze";
    # };
    # initrd.systemd.enable = true;
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      # package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        # offload.enable = true;
        sync.enable = true;

        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";

        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        nvidiaBusId = "PCI:2:0:0";
      };
    };

    opengl = {
      enable = true;
      # driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        # libGL
        mesa.drivers
      ];
    };
  };

  # List services that you want to enable:
  services = {
    touchegg.enable = true;

    gnome.gnome-browser-connector.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      layout = "us, ru";
      # xkbOptions = "grp:alt_shift_toggle";

      videoDrivers = ["nvidia"];

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;

      screenSection = ''
        Option         "ForceFullCompositionPipeline"   "on"
        Option         "AllowIndirectGLXProtocol"       "off"
        Option         "TripleBuffer"                   "on"
      '';

      deviceSection = ''
        Option         "Coolbits"                       "4"
      '';

      displayManager = {
        autoLogin = {
          enable = true;
          user = "denis";
        };

        # gdm.enable = true;
        # sddm.enable = true;
        # lightdm.enable = true;
      };

      desktopManager = {
        gnome.enable = true;
        # plasma5.enable = true;
      };

      windowManager = {
        # i3 = {
        #   enable = true;
        #   package = pkgs.i3-gaps;
        # };

        # xmonad = {
        #   enable = true;
        #   enableContribAndExtras = true;
        #   extraPackages = haskellPackages: [
        #     # haskellPackages.xmonad-wallpaper
        #   ];
        # };

        awesome.enable = true;
      };
    };

    samba = {
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

    avahi = {
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

    # Enable CUPS to print documents.
    printing.enable = true;

    # pipewire = {
    #   enable = true;
    #   alsa.enable = true;
    #   alsa.support32Bit = false;
    #   pulse.enable = true;
    #   # If you want to use JACK applications, uncomment this
    #   jack.enable = false;
    # };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      openFirewall = true;
    };

    # barrier.client = {
    #   enable = true;
    #   enableCrypto = true;
    #   enableDragDrop = false;
    #   name = "Denis-N";
    #   server = "Denis-PC";
    # };

    flatpak.enable = true;
  };

  qt5 = {
    enable = true;
    style = "adwaita-dark";
    # platformTheme = "gnome";
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
  hardware.pulseaudio = {
    enable = true;
    extraConfig = "unload-module module-combine-sink";
  };

  virtualisation = {
    docker = {
      enable = false;
      # enableNvidia = true;
    };

    podman = {
      enable = true;
      # enableNvidia = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };

    virtualbox.host.enable = true;

    libvirtd.enable = true;
  };

  users.extraGroups.vboxusers.members = ["denis"];

  networking = {
    hostName = "Denis-N";
    extraHosts = ''
      188.132.128.77 argocd.panic.io panic.io
      192.168.49.2 argocd.testing.com jaeger.testing.com kiali.testing.com db.testing.com
      172.18.0.2 echo.com
    '';
    networkmanager.enable = true;

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall = {
      enable = true;
      allowedTCPPorts = [
        24800 # Barrier server port
      ];
      allowedUDPPorts = [];
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
    liberation_ttf
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
  system.stateVersion = "22.11"; # Did you read the comment?
}
