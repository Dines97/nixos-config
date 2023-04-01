{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    enableMouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 5000;
    clock24 = true;
    extraConfig = builtins.readFile ./configs/tmux.conf;
    package = pkgs.unstable.tmux;
    plugins = with pkgs.unstable; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
  };
}
