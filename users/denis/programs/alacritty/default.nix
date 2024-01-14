{
  config,
  pkgs,
  ...
}: let
  alacritty-launch =
    pkgs.writeScriptBin "alacritty-launch"
    ''
       xid=$(${pkgs.xdotool}/bin/xdotool search --class Alacritty)

       if [ -z ''${xid} ]
       then
       ${pkgs.alacritty}/bin/alacritty
       else
      ${pkgs.xdotool}/bin/xdotool windowactivate ''${xid}
       fi
    '';
in {
  home = {
    packages = with pkgs; [
      alacritty-launch
    ];
  };

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      colors = {
        draw_bold_text_with_bright_colors = false;
      };
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
      # keyboard = {
      #   bindings = [
      #     {
      #       key = "NumpadEnter";
      #       chars = "\\x0d";
      #     }
      #   ];
      # };
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
