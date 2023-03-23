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

  outputs = {self, ...} @ inputs: let
    pkgs = self.pkgs.x86_64-linux.nixpkgs;
  in
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
          (final: prev: {
            openlens = pkgs.callPackage ./pkgs/openlens-appimage {};
            unstable = channels.nixpkgs-unstable;
          })
        ];
      };

      hostDefaults = {
        modules = [
          inputs.home-manager.nixosModules.home-manager
          ./cachix.nix
          ./hosts/shared
        ];
      };

      hosts.Denis-N = {
        modules = [
          ./hosts/denis-n

          {
            home-manager.users.denis = {...}: {
              imports = [
                ./modules/programs/hstr.nix
                ./modules/programs/tmux.nix
                ./users/denis
                inputs.nix-doom-emacs.hmModule
              ];
            };
          }
        ];
      };
    };
}
