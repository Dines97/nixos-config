{
  config,
  pkgs,
  ...
}: let
  helpers = config.lib.nixvim;
in {
  programs.nixvim = {
    # extraConfigLuaPre = ''
    #   local luasnip = require("luasnip")
    # '';

    plugins = {
      # luasnip = {
      #   enable = true;
      # };

      friendly-snippets = {
        enable = true;
      };

      blink-cmp = {
        enable = true;
        settings = {
          appearance = {
            use_nvim_cmp_as_default = true;
            # nerd_font_variant = "mono";
          };
          # snippets = {
          #   preset = "luasnip";
          # };
          sources = {
            default = ["lsp" "snippets" "buffer" "path" "spell"];
            providers = {
              spell = {
                module = "blink-cmp-spell";
                name = "Spell";
                score_offset = 100;
                opts = {
                };
              };
            };
          };
          completion = {
            menu = {
              draw = {
                columns = [
                  (helpers.listToUnkeyedAttrs ["kind_icon"])
                  ((helpers.listToUnkeyedAttrs ["label" "label_description"]) // {gap = 1;})
                  (helpers.listToUnkeyedAttrs ["source_name"])
                ];
              };
            };
            documentation = {
              auto_show = true;
            };
            list = {
              selection = {
                preselect = false;
                auto_insert = false;
              };
            };
          };
          keymap = {
            preset = "enter";
          };
        };
      };

      blink-cmp-spell = {
        enable = true;
      };

      # cmp = {
      #   enable = true;
      #   autoEnableSources = true;
      #   settings = {
      #     preselect = "cmp.PreselectMode.None";
      #     formatting = {
      #       # Fix for autocomplition window width
      #       format = ''
      #         function(entry, vim_item)
      #           local ELLIPSIS_CHAR = '…'
      #           local MAX_LABEL_WIDTH = 60
      #           local m = vim_item.menu and vim_item.menu or '''
      #           if #m > MAX_LABEL_WIDTH then
      #             vim_item.menu = string.sub(m, 1, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
      #           end
      #           return vim_item
      #         end
      #       '';
      #     };
      #     snippet = {
      #       expand = ''
      #         function(args)
      #           require('luasnip').lsp_expand(args.body)
      #         end
      #       '';
      #     };
      #     mapping = {
      #       __raw = builtins.readFile ./cmp-mapping.lua;
      #     };
      #     sources = [
      #       {
      #         name = "nvim_lsp";
      #         priority = 200;
      #         group_index = 1;
      #       }
      #       {
      #         name = "luasnip";
      #         priority = 190;
      #         group_index = 1;
      #       }
      #       {
      #         name = "buffer";
      #         priority = 100;
      #         group_index = 1;
      #       }
      #       {
      #         name = "path";
      #         priority = 90;
      #         group_index = 1;
      #       }
      #       {
      #         name = "copilot";
      #         priority = 1;
      #         group_index = 2;
      #       }
      #     ];
      #     sorting = {
      #       priority_weight = 100;
      #     };
      #   };
      # };
      # cmp-nvim-lsp.enable = true;
      # cmp-path.enable = true;
      # cmp_luasnip.enable = true;
      # cmp-buffer.enable = true;
    };
  };
}

