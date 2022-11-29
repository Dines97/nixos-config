# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  user-name = "denis";
in
{
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
    settings = {
      auto-optimise-store = true;
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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_testing;

  boot.supportedFilesystems = [ "ntfs" ];

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Configure keymap in X11
    layout = "us, ru";
    # xkbOptions = "grp:alt_shift_toggle";

    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    prime = {
      offload.enable = true;
      # sync.enable = true;

      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";

      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:2:0:0";
    };

    package = config.boot.kernelPackages.nvidiaPackages.beta;

    modesetting.enable = true;
  };

  hardware.opengl = {
    enable = true;
    # extraPackages = with pkgs; [
    #   intel-media-driver # LIBVA_DRIVER_NAME=iHD
    #   vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    #   vaapiVdpau
    #   libvdpau-va-gl
    #   # libGL
    #   mesa.drivers
    # ];
  };

  services.flatpak.enable = true;

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.gnome.gnome-browser-connector.enable = true;

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

  # programs.partition-manager.enable = true;

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  # sound.enable = false;
  hardware.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;


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

  users.extraGroups.vboxusers.members = [ "denis" ];
  virtualisation.virtualbox.host.enable = true;

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

  services = {
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

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
    };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      openFirewall = true;
    };
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LANG = "en_US.UTF-8";

      LC_ALL = "tr_TR.UTF-8";
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
