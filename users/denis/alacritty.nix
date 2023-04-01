{
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
    settings = {
      draw_bold_text_with_bright_colors = false;
      shell = {
        program = "/bin/sh";
        args = ["-l" "-c" "tmux attach || tmux"];
      };
      window = {
        opacity = 0.9;
        dimensions = {
          columns = 140;
          lines = 30;
        };
      };
      font = {
        builtin_box_drawing = true;
        size = 13.0;
        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Bold Italic";
        };
      };
    };
  };
}
