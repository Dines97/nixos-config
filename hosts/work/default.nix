{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

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

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = ["JetBrainsMono" "FiraCode"];
    })
  ];

  environment.noXlibs = false;

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
    };

    extraBin = [
      {src = "/etc/profiles/per-user/denis/bin/node";}
      {src = "/etc/profiles/per-user/denis/bin/npm";}
    ];
  };

  networking.hostName = "work";

  programs = {
    zsh.enable = true;
    nix-ld.dev.enable = true;
  };

  services = {
    preload = {
      enable = false;
    };
  };

  system.stateVersion = "23.11";
}
