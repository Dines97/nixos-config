{
  pkgs,
  lib,
  ...
}: {
  nix = {
    generateNixPathFromInputs = true;
    linkInputs = true;

    settings = {
      auto-optimise-store = true;
      sandbox = true;
      trusted-users = ["root" "@users"];
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "configurable-impure-env"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.denis = {...}: {
      imports = [
        ../../users/denis
      ];
    };
  };

  users = {
    mutableUsers = false;
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
}
