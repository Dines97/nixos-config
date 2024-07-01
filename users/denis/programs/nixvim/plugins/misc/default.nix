{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    presence-nvim = {
      enable = true;
    };
  };
}
