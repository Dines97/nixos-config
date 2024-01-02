{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = flutter-tools-nvim;
        type = "lua";
        config = "require('flutter-tools').setup()";
      }
    ];
    extraPackages = with pkgs; [
    ];
  };
}
