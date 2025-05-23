{
  nixConfig = {
    # Not sure if this is working
    flake-registry = "";
  };

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    "nixpkgs-24.11".url = "github:NixOS/nixpkgs/nixos-24.05";

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

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

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
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    lan-mouse = {
      url = "github:feschber/lan-mouse";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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
          "ventoy-1.1.05"
        ];
      };

      sharedOverlays = [
        inputs.nh.overlays.default
        # inputs.neovim-nightly-overlay.overlays.default
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
          inputs.chaotic.nixosModules.default
        ];
      };

      hosts = {
        Denis-NC = {
          channelName = "nixpkgs-unstable";
          system = "x86_64-linux";
          modules = [
            ./hosts/denis-nc
            inputs.disko.nixosModules.disko
            inputs.home-manager-unstable.nixosModules.home-manager
          ];
        };

        Denis-N = {
          # channelName = "nixpkgs-master";
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
    };
}

