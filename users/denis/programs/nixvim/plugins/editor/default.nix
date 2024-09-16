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
          move = {};
          # trailspace = {};
        };
      };

      trim = {
        enable = true;
        settings = {
          ft_blocklist = [
            "TelescopePrompt"
          ];
          highlight = true;

          trim_last_line = false;
          patterns = [
            # Remove trailing lines
            ''[[%s/\($\n\s*\)\+\%$//]]''

            # Keep one line at the end of file
            ''[[%s/\%$/\r/]]''
          ];
        };
      };

      todo-comments = {
        enable = true;
      };
    };
  };
}

