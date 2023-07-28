{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "preload";

  cfg = config.services.${name};

in
  with lib; {
    options = {
      services.${name} = {
        enable = mkOption {
          default = false;
          type = types.bool;
          description = mdDoc ''
            Enable ${name} service.
          '';
        };

        package = mkOption {
          default = pkgs.${name};
          type = types.package;
          description = mdDoc ''
            Package for ${name} service.
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      users.users.${name} = {
        description = "${name} service user";
        isSystemUser = true;
        group = name;
      };
      users.groups.${name} = {};

      systemd.services.${name} = {
        wantedBy = ["multi-user.target"];
        description = "Adaptive readahead daemon";
        serviceConfig = {
          User = name;
          Group = name;

          Type = "simple";
          IOSchedulingClass = 3;
          ExecStart = ''${cfg.package}/bin/${preload} --foreground'';
          StateDirectory = name;
        };
      };

      environment.systemPackages = [cfg.package];
    };
  }
