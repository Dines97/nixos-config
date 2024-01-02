{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      url = "github:Mic92/nix-index-database";
    };
  };

  description = "System configuration";

  outputs = {self, ...} @ inputs:
    inputs.fup.lib.mkFlake {
      inherit self inputs;

      channelsConfig = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-19.1.9"
        ];
      };

      sharedOverlays = [
        inputs.neovim-nightly-overlay.overlay
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
          inputs.nix-index-database.nixosModules.nix-index
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

      # outputsBuilder = channels: {
      #   packages.python-discord-bot-docker = pkgs.dockerTools.buildImage {
      #     name = "darktts";
      #     tag = "0.1.0";
      #     copyToRoot = self.devShells.x86_64-linux.python-discord-bot;
      #   };
      #
      #   devShells.python-discord-bot = channels.nixpkgs.mkShell {
      #     packages = with channels.nixpkgs.pkgs; [
      #       (python3.withPackages (ps:
      #         with ps; [
      #           nextcord
      #           sqlalchemy
      #           google-cloud-texttospeech
      #           setuptools
      #           psycopg2
      #         ]))
      #     ];
      #   };
      # };

      overlays = inputs.fup.lib.exportOverlays {
        inherit (self) pkgs inputs;
      };

      hmModules = {
        neovim = ./users/denis/programs/neovim;
        tmux = ./users/denis/programs/tmux;
      };
    };
}
