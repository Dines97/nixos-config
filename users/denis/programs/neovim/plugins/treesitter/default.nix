{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./nvim-treesitter.lua;
      }
      {
        plugin = nvim-treesitter-context;
        type = "lua";
        config = builtins.readFile ./nvim-treesitter-context.lua;
      }
    ];

    extraPackages = with pkgs; [
      gcc # For Treesitter
    ];
  };
}
