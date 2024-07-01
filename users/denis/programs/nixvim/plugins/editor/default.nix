{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    gitsigns = {
      enable = true;
    };

    indent-blankline = {
      enable = true;
    };

    virt-column = {
      enable = true;
    };
  };
}
