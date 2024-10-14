{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    extraConfigLuaPre = ''
      -- local minimap = require('mini.map')

      local notify = require('notify')
      local stages = require('notify.stages.static')('top_down')
      vim.notify = notify

      -- Dashboard fix
      vim.cmd('au FileType dashboard lua vim.b.minitrailspace_disable = true')
    '';

    # extraConfigLuaPost = ''
    #   minimap.open()
    # '';

    plugins = {
      web-devicons = {
        enable = true;
      };

      noice = {
        enable = false;
      };

      # All around ui improvement
      dressing = {
        enable = true;
      };

      # Notification
      notify = {
        enable = true;
        timeout = 5000;
        render.__raw = ''"wrapped-compact"'';
        stages = [
          ''
            function(...)
              local opts = stages[1](...)
              if opts then
                opts.border = 'none'
              end
              return opts
            end
          ''
          ''
            unpack(stages, 2)
          ''
        ];
      };

      # File explorer
      neo-tree = {
        enable = true;
        filesystem = {
          scanMode = "deep";
          useLibuvFileWatcher = true;
          hijackNetrwBehavior = "disabled";
        };

        eventHandlers = {
          # enter input pop up with normal mode by default.
          neo_tree_popup_input_ready = ''
            function(input)
              vim.cmd('stopinsert')
            end
          '';
        };
        window.mappings = {
          "<esc>" = "none";
        };
      };

      # Right bottom progress notification
      fidget = {
        enable = true;
        progress = {
          display = {
            doneTtl = 5;
            progressIcon = {
              pattern = "dots";
            };
          };
        };
      };

      # Tab bar
      barbar = {
        enable = true;
      };

      # LSP and file path context menu
      barbecue = {
        enable = true;
      };

      # Left column
      statuscol = {
        enable = true;
      };

      # lsp-status = {
      #   enable = true;
      # };

      mini = {
        modules = {
          files = {};
          animate = {
            # NOTE: Too slow
            scroll = {
              enable = false;
            };
          };
          # map = {
          #   integrations = [
          #     {__raw = "minimap.gen_integration.builtin_search()";}
          #     {__raw = "minimap.gen_integration.diagnostic()";}
          #     {__raw = "minimap.gen_integration.diff()";}
          #     {__raw = "minimap.gen_integration.gitsigns()";}
          #   ];
          # };
        };
      };

      # Bottom line
      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
            theme = "onedark";
            # componentSeparators = {
            #   left = "";
            #   right = "";
            # };
            # sectionSeparators = {
            #   left = "";
            #   right = "";
            # };
          };
          sections = {
            lualine_c = [
              {
                __unkeyed-1 = "filename";
                path = 1;
              }
            ];
            lualine_x = [
              "encoding"
              {
                __unkeyed-1 = "fileformat";
                symbols = {
                  unix = "LF";
                  dos = "CRLF";
                  mac = "CR";
                };
              }
              "filetype"
            ];
          };
        };
      };

      # Start screen plugin
      # dashboard = {
      #   enable = true;
      # };
      alpha = {
        enable = true;
        theme = "startify";
      };
    };
  };
}

