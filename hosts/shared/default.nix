{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  nix = {
    generateNixPathFromInputs = true;
    linkInputs = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
