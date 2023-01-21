{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "/home/denis/home-manager";
      # url = "github:nix-community/home-manager/release-22.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim-nightly-overlay.url = "github:neovim/neovim?dir=contrib";

    # hyprland.url = "github:hyprwm/Hyprland";
  };

  description = "System configuration";

  outputs = {self, ...} @ inputs: let
    system = "x86_64-linux";

    overlay-unstable = final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    # conda-zsh-overlay = final: prev: {
    #   conda = prev.conda.overrideAttrs {
    #     runScript = "zsh -l";
    #   };
    # };
  in {
    nixosConfigurations.Denis-N = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({
          config,
          pkgs,
          ...
        }: {
          nixpkgs.overlays = [
            overlay-unstable
            # inputs.neovim-nightly-overlay.overlay
            # conda-zsh-overlay
          ];
        })

        # Include the results of the hardware scan.
        ./hardware-configuration.nix

        ./cachix.nix

        ./configuration.nix

        # hyprland.nixosModules.default
        # {programs.hyprland.enable = true;}

        inputs.home-manager.nixosModules.home-manager
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
