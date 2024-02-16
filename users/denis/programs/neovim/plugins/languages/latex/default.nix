{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    extraLuaConfig = builtins.readFile ./default.lua;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = knap;
        type = "lua";
        config = builtins.readFile ./knap.lua;
      }
    ];

    extraPackages = with pkgs; [
      # LaTeX
      # texlive.combined.scheme-full # Full LaTeX distribution
      sioyek # Preview
      texlab # LSP
      rubber
    ];
  };
}
