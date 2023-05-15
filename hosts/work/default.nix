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
  users = {
    # mutableUsers = false;

    users = {
      root = {
        isSystemUser = true;
        hashedPassword = "$y$j9T$qI0DM5ydv.oThc7erbbKD.$J.Y6tHHCPUKhoZVkaZjp4BOPqrzUinWSKABMmE7KFW5";
      };

      denis = {
        isNormalUser = true;
        home = "/home/denis";
        description = "Denis Kaynar";
        extraGroups = ["wheel" "networkmanager" "docker" "podman" "libvirtd"];
        shell = pkgs.zsh;
        useDefaultShell = false;
      };
    };
  };

  security = {
    sudo = {
      extraRules = [
        {
          users = ["denis"];
          commands = [
            {
              command = "/run/current-system/sw/bin/podman";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
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

    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   dockerSocket.enable = true;
    # };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = ["JetBrainsMono" "FiraCode"];
    })
  ];

  environment.noXlibs = false;

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "denis";
    startMenuLaunchers = true;

    # Enable native Docker support
    docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = true;

    # nativeSystemd = true;
  };

  networking.hostName = "work";

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.11";
}
