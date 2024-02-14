{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  boot = {
    tmp = {
      cleanOnBoot = true;
    };
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        mesa.drivers
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };

    containers = {
      enable = true;
      registries = {
        insecure = ["registry.turkuazmonitoring.com.tr"];
      };
    };

    podman = {
      enable = true;
      dockerCompat = false;
      dockerSocket.enable = false;
    };
  };

  wsl = {
    enable = true;
    defaultUser = "denis";
    # startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;

    # nativeSystemd = true;

    wslConf = {
      automount = {
        root = "/mnt";
      };

      network = {
        # generateResolvConf = false;
      };
    };

    extraBin = [
      {src = "/etc/profiles/per-user/denis/bin/node";}
      {src = "/etc/profiles/per-user/denis/bin/npm";}
    ];
  };

  networking.hostName = "work";

  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      ports = [
        22
      ];
    };

    preload = {
      enable = false;
    };

    zerotierone = {
      enable = true;
      joinNetworks = [
        "a84ac5c10a88bb46"
      ];
    };

    squid = {
      enable = true;
      extraConfig = ''
        http_access allow all
      '';
    };

    # resolved = {
    #   enable = true;
    #   llmnr = "true";
    # };
  };

  system.stateVersion = "23.11";
}
