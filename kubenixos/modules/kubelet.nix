{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.kubenixos.kubelet;
in
  with lib; {
    options = {
      services.kubenixos.kubelet = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = mdDoc ''
            Start a glances service.
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      systemd.services.kubenixos.kubelet = {
      };
    };
  }
