{
  inputs =
    {
      # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

      nixpkgs.url = "github:NixOS/nixpkgs/release-22.05";
      unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager/release-22.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  description = "System configuration";
  outputs = { self, nixpkgs, home-manager, unstable }: {

    homeManagerConfigurations.denis = home-manager.lib.homeManagerConfiguration {
      modules = [
        ./home.nix
      ];
    };

    nixosConfigurations.Denis-N = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
      ];
    };
  };
}
