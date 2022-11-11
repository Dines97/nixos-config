{
  inputs =
    {
      nixpkgs.url = "github:NixOS/nixpkgs/release-22.05";
      unstable.url = "github:NixOS/nixpkgs/master";

      home-manager = {
        url = "github:nix-community/home-manager/release-22.05";
      };
    };
  description = "main";
  outputs = { self, nixpkgs, unstable, home-manager }: {
    nixosConfigurations.Denis-N = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.denis = import ./home.nix;
        }

      ];
    };
  };

}
