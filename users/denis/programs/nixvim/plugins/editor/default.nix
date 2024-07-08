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
          trailspace = {};
        };
      };

      todo-comments = {
        enable = true;
      };
    };
  };
}
