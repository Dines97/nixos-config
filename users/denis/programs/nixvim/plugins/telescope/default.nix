{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      settings = {
        defaults = {
          sorting_strategy = "ascending";
          sorter.__raw = "require('telescope.sorters').get_fuzzy_file";
        };
        pickers = {
          live_grep = {
            sort_lastused = true;
            sorting_strategy = "ascending";
          };
        };
      };

      extensions = {
        fzf-native = {
          enable = true;
        };
        file-browser = {
          enable = true;
        };
        undo = {
          enable = true;
        };
      };
    };

    neoclip = {
      enable = true;
      # settings = {
      #   enable_persistent_history = true;
      #   continuous_sync = true;
      # };
    };
  };
}

