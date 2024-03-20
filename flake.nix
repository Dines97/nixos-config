{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs";
    # nixpkgs-unstable.url = "git+file:///home/denis/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    fup.url = "github:gytis-ivaskevicius/flake-utils-plus/master";

    # hyprland.url = "github:hyprwm/Hyprland";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  description = "System configuration";

  outputs = {self, ...} @ inputs:
    inputs.fup.lib.mkFlake {
      inherit self inputs;

      channelsConfig = {
        allowUnfree = true;
        # cudaSupport = true;
        permittedInsecurePackages = [
          "electron-19.1.9" # balena etcher
          "squid-6.8" # squid reverse proxy
          "freeimage-unstable-2021-11-01" # mega sync

          "python-2.7.18.7"
        ];
      };

      sharedOverlays = [
        # inputs.neovim-nightly-overlay.overlay
        inputs.rust-overlay.overlays.default
        (import ./overlays)
      ];

      channels = {
        nixpkgs.overlaysBuilder = import ./overlays/stable.nix;
        nixpkgs-unstable.overlaysBuilder = import ./overlays/unstable.nix;
      };

      hostDefaults = {
        modules = [
          ./cachix.nix
          ./modules/default.nix
          ./hosts/shared

          inputs.nix-ld.nixosModules.nix-ld
        ];

        extraArgs = {inherit inputs;};
      };

      hosts = {
        Denis-N = {
          channelName = "nixpkgs-unstable";
          system = "x86_64-linux";
          modules = [
            ./hosts/denis-n
            inputs.home-manager-unstable.nixosModules.home-manager
          ];
        };

        work = {
          channelName = "nixpkgs-unstable";
          system = "x86_64-linux";
          modules = [
            ./hosts/work
            # inputs.home-manager.nixosModules.home-manager
            inputs.home-manager-unstable.nixosModules.home-manager
            inputs.wsl.nixosModules.wsl
          ];
        };
      };

      outputsBuilder = channels: import ./outputs {inherit self channels;};

      overlay = import ./overlays;

      hmModules = inputs.fup.lib.exportModules [
        ./users/denis/programs/neovim
        ./users/denis/programs/tmux
      ];
    };
}
