{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.tmux;
in {
  options.programs.tmux = {
    enableMouse = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable mouse support.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.tmux.extraConfig = mkIf cfg.enableMouse ''
      set -g mouse on
    '';
  };
}
