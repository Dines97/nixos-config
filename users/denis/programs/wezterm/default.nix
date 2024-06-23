{
  config,
  pkgs,
  ...
}: let
  wezterm-launch = pkgs.writeScriptBin "wezterm-launch" ''
    #!/usr/bin/env bash

    xid=$(${pkgs.xdotool}/bin/xdotool search --class WezTerm)

    if [ -z ''${xid} ]
    then
      wezterm
    else
      ${pkgs.xdotool}/bin/xdotool windowactivate ''${xid}
    fi
  '';
in {
  home = {
    packages = [
      wezterm-launch
    ];
  };

  home.file.".config/wezterm/colors/dracula.toml".source = ./dracula.toml;

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
