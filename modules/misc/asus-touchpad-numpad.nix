{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.asus-touchpad-numpad;
in
  with lib; {
    options = {
      services.asus-touchpad-numpad = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = mdDoc ''
            Start Asus touchpad numpad driver
          '';
        };

        model = mkOption {
          type = with types; str;
          description = mdDoc ''
            Model layout
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      hardware.i2c.enable = true;

      systemd.services.asus-touchpad-numpad = {
        description = "Activate Numpad inside the touchpad with top right corner switch";
        documentation = ["https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver"];
        path = [pkgs.i2c-tools];

        script = ''
          cd ${pkgs.asus-touchpad-numpad-driver}

          # In the last argument here you choose your layout.
          ${pkgs.python3.withPackages (ps: [ps.libevdev])}/bin/python asus_touchpad.py ${cfg.model}
        '';

        serviceConfig = {
          RestartSec = "1s";
          Restart = "on-failure";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  }
