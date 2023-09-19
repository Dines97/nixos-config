{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    filetype-nvim.url = "github:nathom/filetype.nvim";
    filetype-nvim.flake = false;
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} ({config, ...}: {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        lib,
        ...
      }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        # packages.default = pkgs.hello;

        packages.vimPlugins = {
          filetype-nvim = pkgs.buildVimPluginFrom2Nix {
            pname = "filetype-nvim";
            version = "1";
            src = inputs.filetype-nvim;
            meta.homepage = "aaa";
          };
        };

        overlayAttrs = {
          inherit (config.packages) filetype-nvim;
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
        overlay = inputs.self.overlays.default;
        defaultPackage = inputs.nixpkgs.lib.genAttrs config.systems (system: inputs.self.packages.${system}.default);
      };
    });
}
