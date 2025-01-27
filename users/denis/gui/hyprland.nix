{
  pkgs,
  config,
  inputs,
  lib,
  osConfig ? null,
  ...
}: {
  programs = {
    # kitty.enable = true;
    waybar = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    settings = {
      "$mainMod" = "SUPER";

      "$terminal" = "wezterm start --always-new-process";
      "$browser" = "firefox";
      "$menu" = "rofi -show drun";

      exec-once = [
        "waybar"
      ];

      monitor = [
        ",prefered, auto, 1"
      ];

      bind = [
        "$mainMod, F, exec, $browser"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"

        "ALT, SPACE, exec, $menu"

        "$mainMod, Q, exec, $terminal"
        "$mainMod, Return, exec, $terminal"
      ];
    };
  };
}

