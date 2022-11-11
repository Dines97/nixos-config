{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.hyprland;
in
{
  imports = [

  ];

  options.programs.hyprland = {
    enable = mkEnableOption "Hyprland is a dynamic tiling Wayland compositor that doesn't sacrifice on its looks.";

    package = mkOption {
      type = types.package;
      default = pkgs.hyprland;
      defaultText = literalExpression "pkgs.hyprland";
      example = literalExpression "pkgs.hyprland";
      description = "Hyprland package to use.";
    };

    extraPackages = mkOption {
      type = with types; listOf package;
      default = with pkgs; [ swaylock ];
      defaultText = literalExpression "with pkgs; [ swaylock ]";
      description = "Extra packages to be installed system wide.";
    };

    extraOptions = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ ];
      description = "Command line arguments passed to launch Hyprland.";
    };

    config = mkIf cfg.enable {
      services.xserver.displayManager.sessionPackages = [ cfg.package ];

      environment = {
        systemPackages = [ cfg.package ] ++ cfg.extraPackages;
      };

      security.pam.services.swaylock = { };
      # services.xserver.windowsmanager.session = [{
      #   name = "hyprland";
      #   start =
      #     }];

    };
  };
}
