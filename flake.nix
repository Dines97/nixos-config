{
  nixConfig = {
    # Not sure if this is working
    flake-registry = "";
  };

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    "nixpkgs-24.05".url = "github:NixOS/nixpkgs/nixos-24.05";
    # "nixpkgs-23.11".url = "github:NixOS/nixpkgs/nixos-23.11";

    # home-manager = {
    #   url = "github:nix-community/home-manager/release-23.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    fup.url = "github:gytis-ivaskevicius/flake-utils-plus/master";

    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    # hyprland.url = "github:hyprwm/Hyprland";

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  description = "System configuration";

  outputs = inputs:
    inputs.fup.lib.mkFlake {
      inherit (inputs) self;
      inherit inputs;

      channelsConfig = {
        allowUnfree = true;
        # cudaSupport = true;
        permittedInsecurePackages = [
          "squid-6.8" # squid reverse proxy
        ];
      };

      sharedOverlays = [
        inputs.nix-ld.overlays.default
        inputs.neovim-nightly-overlay.overlays.default
        inputs.nh.overlays.default
        (import ./overlays)
      ];

      channels = {
        nixpkgs.overlaysBuilder = import ./overlays/stable.nix;
        nixpkgs-unstable.overlaysBuilder = import ./overlays/unstable.nix;
      };

      hostDefaults = {
        modules = [
          ./modules/default.nix
          ./hosts/shared

          inputs.sops-nix.nixosModules.sops
        ];
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

      outputsBuilder = channels:
        import ./outputs {
          inherit (inputs) self;
          inherit channels;
        };

      overlay = import ./overlays;

      hmModules = inputs.fup.lib.exportModules [
        ./users/denis/programs/neovim
        ./users/denis/programs/tmux
      ];
    };
}
