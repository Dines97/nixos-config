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

    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 3; # How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 1; # Maximum number of lines to show for a single context
      };
    };
  };
}
