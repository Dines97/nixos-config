{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    opts = {
      colorcolumn = "100";
    };

    plugins = {
      gitsigns = {
        enable = true;
      };

      indent-blankline = {
        enable = true;
      };

      virt-column = {
        enable = true;
      };

      mini = {
        modules = {
          move = {
            mappings = {
              left = "<C-Left>";
              down = "<C-Down>";
              up = "<C-Up>";
              right = "<C-Right>";

              line_left = "<C-Left>";
              line_down = "<C-Down>";
              line_up = "<C-Up>";
              line_right = "<C-Right>";
            };
          };
          trailspace = {};
        };
      };

      # trim = {
      #   enable = true;
      #   settings = {
      #     highlight = false;
      #
      #     trim_last_line = false;
      #     patterns = [
      #       # Remove trailing lines
      #       ''[[%s/\($\n\s*\)\+\%$//]]''
      #
      #       # Keep one line at the end of file
      #       ''[[%s/\%$/\r/]]''
      #     ];
      #   };
      # };

      todo-comments = {
        enable = true;
      };
    };
  };
}

