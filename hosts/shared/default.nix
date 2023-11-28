{...}: {
  nix = {
    generateNixPathFromInputs = true;
    linkInputs = true;

    settings = {
      auto-optimise-store = true;
      trusted-users = ["root" "@users"];
      experimental-features = ["nix-command" "flakes"];
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
}
