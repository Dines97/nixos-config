{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    smart-splits = {
      enable = true;
      settings = {
        default_amount = 1;
        at_edge = "stop";
      };
    };
  };
}
