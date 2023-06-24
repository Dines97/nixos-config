{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    shortcut = "b";
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 5000;
    clock24 = true;
    extraConfig = builtins.readFile ./configs/tmux.conf;
    package = pkgs.tmux;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
  };
}
