{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimUtils;
    with pkgs.vimPlugins; [
      # {
      #   plugin = tmux-nvim;
      #   type = "lua";
      #   config = builtins.readFile ./tmux.lua;
      # }
      {
        plugin = smart-splits-nvim;
        type = "lua";
        config = builtins.readFile ./smart-splits.lua;
      }
    ];
  };
}
