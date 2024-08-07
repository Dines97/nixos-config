{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      none-ls = {
        enable = true;
      };
      lsp = {
        enable = true;
        inlayHints = true;

        keymaps = {
          extra = lib.lists.map (x:
            lib.attrsets.recursiveUpdate {
              mode = ["n"];
              options = {
                buffer = true;
                noremap = true;
                silent = true;
              };
            }
            x) [
            # vim.diagnostic
            {
              action.__raw = "vim.diagnostic.open_float";
              key = "<leader>de";
              options.desc = "Open float";
            }
            {
              action.__raw = "vim.diagnostic.setloclist";
              key = "<leader>dq";
              options.desc = "setloclist";
            }
            {
              action.__raw = "vim.diagnostic.goto_prev";
              key = "[d";
              options.desc = "Goto prev";
            }
            {
              action.__raw = "vim.diagnostic.goto_next";
              key = "]d";
              options.desc = "Goto next";
            }

            # vim.lsp.buf
            {
              action.__raw = "vim.lsp.buf.declaration";
              key = "<leader>lD";
              options.desc = "Declaration";
            }
            {
              action.__raw = "vim.lsp.buf.definition";
              key = "<leader>ld";
              options.desc = "Definition";
            }
            {
              action.__raw = "vim.lsp.buf.implementation";
              key = "<leader>li";
              options.desc = "Implementation";
            }
            {
              action.__raw = "vim.lsp.buf.references";
              key = "<leader>lR";
              options.desc = "References";
            }
            {
              action.__raw = "vim.lsp.buf.type_definition";
              key = "<leader>lt";
              options.desc = "Type definition";
            }
            {
              action.__raw = "vim.lsp.buf.signature_help";
              key = "<leader>lk";
              options.desc = "Signature help";
            }
            {
              action.__raw = "vim.lsp.buf.hover";
              key = "<leader>lK";
              options.desc = "Hover";
            }
            {
              action.__raw = "vim.lsp.buf.rename";
              key = "<leader>lr";
              options.desc = "Rename";
            }
            {
              action.__raw = "vim.lsp.buf.code_action";
              key = "<leader>la";
              options.desc = "Code action";
            }
            {
              action.__raw = ''
                function()
                  local mini_trailspace = require('mini.trailspace')

                  mini_trailspace.trim()
                  mini_trailspace.trim_last_lines()

                  -- Needs to be async false or format could happend after write
                  vim.lsp.buf.format { async = false }

                  vim.api.nvim_command('write')
                end
              '';
              key = "<leader>lf";
              options.desc = "Format";
            }
            {
              action.__raw = ''
                function()
                  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end
              '';
              key = "<leader>lv";
              options.desc = "Toogle inlay hint";
            }

            # vim.lsp.buf.
            # workspace
            {
              action.__raw = "vim.lsp.buf.add_workspace_folder";
              key = "<leader>wa";
              options.desc = "Add workspace folder";
            }
            {
              action.__raw = "vim.lsp.buf.remove_workspace_folder";
              key = "<leader>wr";
              options.desc = "Remove workspace folder";
            }
            {
              action.__raw = "function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end";
              key = "<leader>wl";
              options.desc = "List workspace folder";
            }
          ];
        };
      };
      trouble = {
        enable = true;
      };

      # LSP context in win bar
      navic = {
        enable = true;
        lsp = {
          autoAttach = true;
        };
      };

      # Code actions as light bulb
      nvim-lightbulb = {
        enable = true;
        settings = {
          autocmd = {
            enabled = true;
          };

          # sign = {
          #   enabled = false;
          # };
          #
          # virtual_text = {
          #   enabled = true;
          # };
        };
      };
    };
  };
}
