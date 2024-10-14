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

      bind =
        [
          "$mainMod, F, exec, $browser"

          "$mainMod, Q, exec, $terminal"
          "$mainMod, Return, exec, $terminal"
        ]
        ++ (
          # workspaces
          # binds $mainMod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };
}

