{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.vagrant;

  boxOptions = {...}: {
    options = {
      name = lib.mkOption {};
      type = lib.types.str;
      description = lib.mdDoc ''
        Name of the vagrant box
      '';
    };
  };

  mkService = name: box: let
  in {
  };
in
  with lib; {
    options = {
      services.vagrant = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = mdDoc ''
            Enable vagrant managed boxes.
          '';
        };

        package = mkOption {
          default = pkgs.vagrant;
          type = types.package;
          description = mdDoc ''
            Package for vagrant.
          '';
        };

        boxes = lib.mkOption {
          default = {};
          type = lib.types.attrsOf (types.submodule boxOptions);
          description = lib.mdDoc ''
            Vagrant boxes to run as systemd services.
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      systemd.services = lib.mapAttrs' (name: value: lib.nameValuePair "vagrant-${name}" (mkService name value)) cfg.boxes;
    };
  }
