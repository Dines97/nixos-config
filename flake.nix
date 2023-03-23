{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "/home/denis/home-manager";

      url = "github:nix-community/home-manager/release-22.11";
      # url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";

    # hyprland.url = "github:hyprwm/Hyprland";

    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  description = "System configuration";

  outputs = {self, ...} @ inputs:
    inputs.fup.lib.mkFlake {
      inherit self inputs;

      channelsConfig = {
        allowUnfree = true;
        allowBroken = false;
      };

      sharedOverlays = [
        # conda-zsh-overlay = final: prev: {
        #   conda = prev.conda.overrideAttrs {
        #     runScript = "zsh -l";
        #   };
        # };
      ];

      channels.nixpkgs = {
        overlaysBuilder = channels: [
          (final: prev: {unstable = channels.nixpkgs-unstable;})
        ];
      };

      hostDefaults = {
        modules = [
          {
            nix = {
              generateNixPathFromInputs = true;
              linkInputs = true;
              settings = {
                experimental-features = ["nix-command" "flakes"];
              };
            };
          }
        ];
      };

      hosts.Denis-N = {
        modules = [
          ./hardware-configuration.nix
          ./cachix.nix
          ./configuration.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.denis = {...}: {
              imports = [./home.nix inputs.nix-doom-emacs.hmModule];
            };
          }
        ];
      };
    };
}
