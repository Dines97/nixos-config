{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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

    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";

    # hyprland.url = "github:hyprwm/Hyprland";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    neovim-plugins.url = "path:neovim";
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
          awmtt = pkgs.callPackage ./pkgs/awmtt {};
          aawmtt = pkgs.callPackage ./pkgs/aawmtt {};
          teams = prev.teams.overrideAttrs (old: {
            src = ./teams.deb;
          });
          preload = pkgs.callPackage ./pkgs/preload {};
          wezterm = prev.wezterm.overrideAttrs (old: {
            postInstall =
              old.postInstall
              + ''
                substituteInPlace $out/share/applications/org.wezfurlong.wezterm.desktop --replace \
                "Exec=wezterm start --cwd ." \
                "Exec=wezterm"
              '';
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
          inherit (channels.nixpkgs-unstable) helm-ls;
          vimPlugins =
            prev.vimPlugins
            // {
              inherit (channels.nixpkgs-unstable.vimPlugins) vim-helm;
            };
        })
      ];

      channels.nixpkgs-unstable.overlaysBuilder = channels: [
        inputs.neovim-nightly-overlay.overlay
        inputs.neovim-plugins.overlay
        # inputs.neovim-plugins.
      ];

      hostDefaults = {
        modules = [
          ./cachix.nix
          ./hosts/shared
          ./modules/services/monitoring/glances.nix
          ./modules/services/misc/preload.nix
        ];
      };

      hosts.Denis-N = {
        channelName = "nixpkgs-unstable";
        modules = [
          ./hosts/denis-n
          inputs.home-manager-unstable.nixosModules.home-manager

          {
            home-manager.users.denis = {...}: {
              imports = [
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

          inputs.home-manager.nixosModules.home-manager
          inputs.wsl.nixosModules.wsl

          {
            home-manager.users.denis = {...}: {
              imports = [
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
