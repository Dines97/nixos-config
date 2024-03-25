{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    extraLuaConfig = builtins.readFile ./default.lua;

    plugins = with pkgs.vimPlugins; [
      yaml-companion-nvim
    ];

    extraPackages = with pkgs; [
      nodePackages.yaml-language-server
    ];
  };
}
