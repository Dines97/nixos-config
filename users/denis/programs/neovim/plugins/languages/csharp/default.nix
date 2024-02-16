{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    extraLuaConfig = builtins.readFile ./default.lua;

    plugins = with pkgs.vimPlugins; [
      omnisharp-extended-lsp-nvim
    ];
    extraPackages = with pkgs; [
      # C#
      omnisharp-roslyn
    ];
  };
}
