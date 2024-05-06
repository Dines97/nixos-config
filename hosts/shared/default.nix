{
  pkgs,
  lib,
  inputs,
  ...
}: let
  # Not sure if this is working
  emptyFlakeRegistry = pkgs.writeText "flake-registry.json" (builtins.toJSON {
    flakes = [];
    version = 2;
  });
in {
  nix = {
    package = pkgs.nixVersions.git;

    generateNixPathFromInputs = true;
    linkInputs = true;

    settings = {
      auto-optimise-store = true;
      sandbox = true;
      trusted-users = ["root" "nix-ssh" "@users"];
      experimental-features = [
        "nix-command"
        "flakes"
        # "auto-allocate-uids"
        # "configurable-impure-env"
      ];
      substituters = lib.mkBefore [
        "ssh://denis@dt826.local"
      ];
      # require-sigs = false;

      # trusted-public-keys = [
      #   "ssh-ng://vodka@5.178.111.177"
      # ];
      #
      # trusted-substituters = [
      # ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    buildMachines = [
      {
        hostName = "denis@dt826.local";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 8;
        speedFactor = 4;
        # supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        # mandatoryFeatures = [];
      }
      # {
      #   hostName = "vodka@5.178.111.177";
      #   system = "x86_64-linux";
      #   protocol = "ssh-ng";
      #   maxJobs = 4;
      #   speedFactor = 2;
      #   # supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      #   # mandatoryFeatures = [];
      # }
    ];

    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
      flake-registry = ${emptyFlakeRegistry}
    '';
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    users.denis = {...}: {
      imports = [
        ../../users/denis
        # inputs.nix-index-database.hmModules.nix-index
      ];
    };
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      root = {
        isSystemUser = true;
        hashedPassword = "$y$j9T$2aadTOomlIU9AoO.iP1vf.$WCP8oD7Zl0LLSG0WDnUliBLsasLLclKfHCdugsPMsu3";
      };
      denis = {
        isNormalUser = true;
        home = "/home/denis";
        description = "Denis Kaynar";
        extraGroups = ["wheel" "networkmanager" "docker" "podman" "libvirtd"];
        shell = pkgs.zsh;
        useDefaultShell = false;
        hashedPassword = "$y$j9T$3ehlIN5zwQLx8bj0JhukK/$6caMKJkpHx5BRFQHzbciUYjEubzFNGl0yY.MTZx.6P0";
      };
    };
  };

  security = {
    polkit.enable = true;

    # rtkit is optional but recommended
    rtkit.enable = true;

    sudo = {
      wheelNeedsPassword = true;

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

  programs = {
    zsh.enable = true;

    nix-ld = {
      enable = true;
      dev.enable = false;

      # libraries = with pkgs; [
      #   zlib
      #   zstd
      #   stdenv.cc.cc
      #   curl
      #   openssl
      #   attr
      #   libssh
      #   bzip2
      #   libxml2
      #   acl
      #   libsodium
      #   util-linux
      #   xz
      #   systemd
      #
      #   coreutils # For conda
      #
      #   # glib
      #
      #   # libbsd # For pulse secure
      #   # glib
      #   # gtkmm3
      #   # atkmm
      #   # glibmm
      #   # pangomm
      #   # gtk3
      #   # gnome2.pango
      #   # at-spi2-atk
      #   # cairo
      #   # cairomm
      #   # libsigcxx
      #   # gdk-pixbuf
      #   # webkitgtk
      #   # gnome.libsoup
      # ];
    };

    command-not-found = {
      enable = false;
    };
  };

  fonts.packages = with pkgs; [
    # google-fonts
    (nerdfonts.override {
      fonts = ["JetBrainsMono" "FiraCode"];
    })
  ];
}
