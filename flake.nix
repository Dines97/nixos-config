{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      # url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

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
        permittedInsecurePackages = [
          "electron-12.2.3" # For etcher
        ];
      };

      sharedOverlays = [
        (final: prev: {
          openlens = pkgs.callPackage ./pkgs/openlens-appimage {};
          awmtt = pkgs.callPackage ./pkgs/awmtt {};
          aawmtt = pkgs.callPackage ./pkgs/aawmtt {};
          teams = prev.teams.overrideAttrs (old: {
            src = ./teams.deb;
          });
        })

        # conda-zsh-overlay = final: prev: {
        #   conda = prev.conda.overrideAttrs {
        #     runScript = "zsh -l";
        #   };
        # };
      ];

      channels.nixpkgs.overlaysBuilder = channels: [
        (final: prev: {
        })
      ];

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
                ./modules/programs/tmux.nix
                ./users/denis
                # inputs.nix-doom-emacs.hmModule
              ];
            };
          }
        ];
      };

      hosts.work = {
        modules = [
          ./hosts/work

          inputs.wsl.nixosModules.wsl

          {
            home-manager.users.denis = {...}: {
              imports = [
                ./modules/programs/tmux.nix
                ./users/denis
                # inputs.nix-doom-emacs.hmModule
              ];
            };
          }
        ];
      };

      hmModules = {
        neovim = ./users/denis/neovim.nix;
        tmux = ./users/denis/tmux.nix;
      };
    };
}
