{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./cachix.nix
    ./nix.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      inputs.nix-index-database.hmModules.nix-index
      inputs.nixvim.homeManagerModules.nixvim
      inputs.lan-mouse.homeManagerModules.default

      # ../../users/denis/programs/nixvim/modules/default.nix
    ];

    backupFileExtension = "home-manager.backup";

    users.denis = {...}: {
      imports = [
        ../../users/denis
      ];
    };

    extraSpecialArgs = {
      inherit inputs;
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
        extraGroups = ["wheel" "networkmanager" "docker" "podman" "libvirtd" "video" "render"];
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
      #   # folding@home
      #   # amdvlk
      #   # clinfo
      #   # libcxx
      #   # rocmPackages.clr
      #   # rocmPackages.clr.icd
      #   # rocmPackages.hipblas
      #   # rocmPackages.rocblas
      #   # rocmPackages.rocm-runtime
      #   # rocmPackages.rocminfo
      #   # stdenv.cc.cc
      # ];
    };

    command-not-found = {
      enable = false;
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--nogc --nogcroots";
        dates = "weekly";
      };
    };
  };

  fonts.packages = with pkgs; [
    # google-fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    mplus-outline-fonts.githubRelease
  ];
}

