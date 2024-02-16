{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    extraLuaConfig = builtins.readFile ./default.lua;

    plugins = with pkgs.vimPlugins; [
    ];

    extraPackages = with pkgs; [
      nodePackages.pyright
      python310Packages.black
      # python310Packages.jedi-language-server
    ];
  };
}
