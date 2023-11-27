{
  config,
  pkgs,
  ...
}: {
  enable = true;
  extraConfig = builtins.readFile ./wezterm.lua;
}
