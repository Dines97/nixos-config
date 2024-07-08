{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      indent = true;
      nixvimInjections = true;
      incrementalSelection = {
        enable = true;
      };
      gccPackage = pkgs.gcc;
    };

    # FIX: Error out when scrolling upward
    treesitter-context = {
      enable = false;
      settings = {
        max_lines = 3; # How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 1; # Maximum number of lines to show for a single context
      };
    };
  };
}
