{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.glances;
in
  with lib; {
    options = {
      services.glances = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = mdDoc ''
            Start a glances service.
          '';
        };

        package = mkOption {
          default = pkgs.glances;
          type = types.package;
          description = mdDoc ''
            Package for glances service.
          '';
        };

        port = mkOption {
          type = types.port;
          default = 61208;
          description = mdDoc ''
            Glances webserver port.
          '';
        };

        openFirewall = mkOption {
          type = types.bool;
          default = true;
          description = mdDoc ''
            Whether to open a firewall port for the glances.
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      users.users.glances = {
        description = "Glances service user";
        isSystemUser = true;
        group = "glances";
      };
      users.groups.glances = {};

      systemd.services.glances = {
        wantedBy = ["multi-user.target"];
        after = ["network.target"];
        description = "Glances";
        serviceConfig = {
          User = "glances";
          ExecStart = ''${cfg.package}/bin/glances -w'';

          Restart = "on-abort";
          RemainAfterExit = "yes";
        };
      };

      environment.systemPackages = [cfg.package];
    };
  }
