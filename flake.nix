{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "/home/denis/home-manager";
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ros = {
      url = "github:lopsided98/nix-ros-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "github:hyprwm/Hyprland";
  };

  description = "System configuration";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    # hyprland,
    ros,
  }: let
    system = "x86_64-linux";

    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

    overlay-ros = final: prev: {
      ros = import ros {
        inherit system;
      };
    };

    overlay-pkgs = self: super: {
      openlens = super.callPackage ./pkgs/openlens {};
    };
  in {
    nixosConfigurations.Denis-N = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({
          config,
          pkgs,
          ...
        }: {nixpkgs.overlays = [overlay-unstable overlay-ros overlay-pkgs];})

        # Include the results of the hardware scan.
        ./hardware-configuration.nix

        ./cachix.nix

        ./configuration.nix

        # hyprland.nixosModules.default
        # {programs.hyprland.enable = true;}

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.denis = import ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
