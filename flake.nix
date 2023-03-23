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

    # hyprland.url = "github:hyprwm/Hyprland";

    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
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
            (final: prev: {
              libratbag1 = prev.libratbag.overrideAttrs (old: {
                patches = [
                  ./rival-3.patch
                ];

                src = prev.fetchFromGitHub {
                  owner = "Dines97";
                  repo = "libratbag";
                  rev = "925b2a2a0a6b5a5f37fe851b38b1b06490f9e6cc";
                  sha256 = "sha256-TQ8DVj4yqq3IA0oGnLDz+QNTyNRmGqspEjkPeBmXNew=";
                };
              });
            })
            # (final: prev: {
            #   piper = prev.piper.overrideAttrs (old: {
            #       mesonFlags = [
            #     "-Druntime-dependency-checks=false"
            #   ];
            #   buildInputs = with pkgs; [
            #     gtk3 glib gnome.adwaita-icon-theme python3 librsvg appstream
            #   ];
            #
            # propagatedBuildInputs = with pkgs.python3.pkgs; [ lxml evdev pygobject3 pathlib2];
            #
            #   nativeBuildInputs = with pkgs; [ meson ninja gettext pkg-config wrapGAppsHook desktop-file-utils appstream-glib gobject-introspection appstream ];
            #
            #     src = prev.fetchFromGitHub {
            #           owner  = "libratbag";
            #     repo   = "piper";
            #     rev = "05cd7a70310a2944a636202f0681b602ba409ee7";
            #         sha256 = "sha256-HvZor8D0/+9MG0xESGrQnTfOGr8El3lf0IEYuzprvxM=";
            #       };
            #
            #     });
            #
            #   }
            # )

            # conda-zsh-overlay
            # inputs.neovim-nightly-overlay.overlay
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
          # home-manager.users.denis = import ./home.nix;
          home-manager.users.denis = {...}: {
            imports = [./home.nix inputs.nix-doom-emacs.hmModule];
          };

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
