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
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    settings = {
      "$mainMod" = "SUPER";

      "$terminal" = "wezterm";
      "$browser" = "firefox";

      exec-once = [
        "waybar"
      ];

      bind = [
        "$mainMod, F, exec, $browser"

        "$mainMod, Q, exec, $terminal"
        "$mainMod, Return, exec, $terminal"
      ];
    };
  };
}

