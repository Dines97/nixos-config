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
        eventHandlers = {
          # enter input pop up with normal mode by default.
          neo_tree_popup_input_ready = ''
            function(input)
              vim.cmd('stopinsert')
            end
          '';
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

        sections = {
          lualine_c = [
            {
              name = "filename";
              extraConfig.path = 1;
            }
          ];
          lualine_x = [
            {name = "encoding";}
            {
              name = "fileformat";
              extraConfig = {
                symbols = {
                  unix = "LF";
                  dos = "CRLF";
                  mac = "CR";
                };
              };
            }
            {name = "filetype";}
          ];
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
