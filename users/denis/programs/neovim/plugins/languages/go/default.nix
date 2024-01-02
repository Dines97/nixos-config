{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
    ];
    extraPackages = with pkgs; [
      # Go
      gopls
      delve
    ];
  };
}
