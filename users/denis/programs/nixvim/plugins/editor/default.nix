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
              left = "<C-S-h>";
              down = "<C-S-j>";
              up = "<C-S-k>";
              right = "<C-S-l>";

              line_left = "<C-S-h>";
              line_down = "<C-S-j>";
              line_up = "<C-S-k>";
              line_right = "<C-S-l>";
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

