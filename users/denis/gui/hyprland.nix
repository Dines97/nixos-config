{
  pkgs,
  config,
  inputs,
  lib,
  osConfig ? null,
  ...
}: {
  # programs.kitty.enable = true;
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   # set the flake package
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   settings = {
  #     "$mod" = "SUPER";
  #     bind =
  #       [
  #         "$mod, F, exec, firefox"
  #       ]
  #       ++ (
  #         # workspaces
  #         # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
  #         builtins.concatLists (builtins.genList (
  #             i: let
  #               ws = i + 1;
  #             in [
  #               "$mod, code:1${toString i}, workspace, ${toString ws}"
  #               "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
  #             ]
  #           )
  #           9)
  #       );
  #   };
  # };
}

