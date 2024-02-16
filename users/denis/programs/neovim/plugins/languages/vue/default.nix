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
      nodePackages.vue-language-server
      nodePackages.volar # Language server for Vue
    ];
  };
}
