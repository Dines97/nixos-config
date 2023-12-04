{
  config,
  lib,
  pkgs,
  ...
}: {
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
      {
        plugin = tmuxPlugins.mode-indicator;
        extraConfig = ''
          set -g status-right '#{pane_title} %Y-%m-%d %H:%M #{tmux_mode_indicator}'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "suspend";
          version = "";
          src = fetchFromGitHub {
            owner = "MunifTanjim";
            repo = "tmux-suspend";
            rev = "1a2f806666e0bfed37535372279fa00d27d50d14";
            hash = "sha256-+1fKkwDmr5iqro0XeL8gkjOGGB/YHBD25NG+w3iW+0g=";
          };
        };
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
