{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./plugins
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    # package = pkgs.neovim-nightly;
    # defaultEditor = true;

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
