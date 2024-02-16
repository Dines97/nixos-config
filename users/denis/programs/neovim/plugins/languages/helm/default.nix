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
      # Helm
      helm-ls
    ];
  };
}
