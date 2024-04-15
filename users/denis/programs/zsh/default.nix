{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
    };

    localVariables = {
      ZSH_TMUX_AUTOSTART = true;
      ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "kubectx" "tmux" "rust"];
      theme = "robbyrussell";
    };

    zplug = {
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-syntax-highlighting";
        }
      ];
    };
  };
}
