{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      # tmux-yank required dependency
      xsel
      xclip

      wl-clipboard
      # wl-clipboard-rs
    ];
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    shortcut = lib.mkOptionDefault "b";
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 5000;
    clock24 = true;
    extraConfig = builtins.readFile ./tmux.conf;
    package = pkgs.tmux;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.open
      {
        plugin = tmuxPlugins.mode-indicator;
        extraConfig = ''
          set -g status-right '#{pane_title} %Y-%m-%d %H:%M #{tmux_mode_indicator}'
        '';
      }
      {
        plugin = tmuxPlugins.suspend;
        extraConfig = ''
          set -g @suspend_key 'F12'
          set -g @suspend_suspended_options " \
            @mode_indicator_custom_prompt:: ---- , \
            @mode_indicator_custom_mode_style::bg=brightblack\\,fg=black, \
          "
        '';
      }
    ];
  };
}
