{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  description = "System configuration";

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable }:
    let
      system = "x86_64-linux";
      unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations.Denis-N = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.denis = import ./home.nix;

            home-manager.extraSpecialArgs = { inherit unstable; };


            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
}

