{
  inputs =
    {
      nixpkgs.url = "github:NixOS/nixpkgs/release-22.05";
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

      home-manager = {
        url = "github:nix-community/home-manager";
      };
    };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }: {
    nixosConfigurations.Denis-N = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home.manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.denis = import ./home.nix;
        }

      ];
    };
  };
}
