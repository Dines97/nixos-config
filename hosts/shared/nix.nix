{
  pkgs,
  lib,
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

    # generateNixPathFromInputs = true;
    # linkInputs = true;

    settings = {
      auto-optimise-store = true;
      sandbox = true;
      trusted-users = ["root" "@users"];
      experimental-features = [
        "nix-command"
        "flakes"
        # "auto-allocate-uids"
        # "configurable-impure-env"
      ];
      substituters = [
        "https://cache.nixos.org/"
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

    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
      flake-registry = ${emptyFlakeRegistry}
    '';
  };
}
