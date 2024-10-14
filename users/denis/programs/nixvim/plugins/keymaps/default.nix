{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    extraConfigLuaPre = ''
      local miniclue = require('mini.clue')
    '';
    plugins = {
      mini = {
        modules = {
          clue = {
            triggers = [
              # Leader triggers
              {
                mode = "n";
                keys = "<leader>";
              }
              {
                mode = "x";
                keys = "<leader>";
              }

              # Local leader triggers
              {
                mode = "n";
                keys = "<localleader>";
              }
              {
                mode = "x";
                keys = "<localleader>";
              }

              # Built-in completion
              {
                mode = "i";
                keys = "<C-x>";
              }

              # `g` key
              {
                mode = "n";
                keys = "g";
              }
              {
                mode = "x";
                keys = "g";
              }

              # Marks
              {
                mode = "n";
                keys = "'";
              }
              {
                mode = "n";
                keys = "`";
              }
              {
                mode = "x";
                keys = "'";
              }
              {
                mode = "x";
                keys = "`";
              }

              # Registers
              {
                mode = "n";
                keys = "\"";
              }
              {
                mode = "x";
                keys = "\"";
              }
              {
                mode = "i";
                keys = "<C-r>";
              }
              {
                mode = "c";
                keys = "<C-r>";
              }

              # Window commands
              {
                mode = "n";
                keys = "<C-w>";
              }

              # `z` key
              {
                mode = "n";
                keys = "z";
              }
              {
                mode = "x";
                keys = "z";
              }
            ];
            clues = [
              {
                mode = "n";
                keys = "<leader>l";
                desc = "+LSP";
              }
              {
                mode = "n";
                keys = "<leader>L";
                desc = "+LSP audit";
              }
              {
                mode = "n";
                keys = "<leader>r";
                desc = "+Trouble";
              }
              {
                mode = "n";
                keys = "<leader>w";
                desc = "+Workspace";
              }
              {
                mode = "n";
                keys = "<leader>d";
                desc = "+Diagnostic";
              }
              {
                mode = "n";
                keys = "<leader>t";
                desc = "+Telescope";
              }
              {
                mode = "n";
                keys = "<leader>e";
                desc = "+Explorer";
              }

              {__raw = "miniclue.gen_clues.builtin_completion()";}
              {__raw = "miniclue.gen_clues.g()";}
              {__raw = "miniclue.gen_clues.marks()";}
              {__raw = "miniclue.gen_clues.registers()";}
              {__raw = "miniclue.gen_clues.windows()";}
              {__raw = "miniclue.gen_clues.z()";}
            ];
            window = {
              delay = 0;
              # config = {
              #   anchor = "SE";
              #   row = "auto";
              #   col = 3;
              # };
            };
          };
        };
      };

      # which-key = {
      #   enable = true;
      #   registrations = {
      #     "<leader>" = {
      #       l = "LSP";
      #       L = "LSP audit";
      #       r = "Trouble";
      #       w = "Workspace";
      #       d = "Diagnostic";
      #       t = "Telescope";
      #       e = "Explorer";
      #     };
      #   };
      # };

      # legendary = {
      #   enable = true;
      #   settings = {
      #     extensions = {
      #       smart_splits = true;
      #     };
      #     # keymaps = [
      #     #   {
      #     #     key = "<S-h>";
      #     #     action = "<cmd>BufferPrevious<cr>";
      #     #   }
      #     #   {
      #     #     key = "<S-l>";
      #     #     action = "<cmd>BufferNext<cr>";
      #     #   }
      #     # ];
      #   };
      # };
    };
  };
}

