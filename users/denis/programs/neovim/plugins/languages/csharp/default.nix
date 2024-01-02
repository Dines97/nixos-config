{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      omnisharp-extended-lsp-nvim
    ];
    extraPackages = with pkgs; [
      # C#
      omnisharp-roslyn
    ];
  };
}
