local mini_trailspace = require('mini.trailspace')

require('legendary').setup({
  keymaps = {
    -- Better window movement
    -- ["<C-h>"] = "<C-w>h",
    -- ["<C-j>"] = "<C-w>j",
    -- ["<C-k>"] = "<C-w>k",
    -- ["<C-l>"] = "<C-w>l",
    --
    -- Resize with arrows
    { '<C-Up>',    function() require('tmux').resize_top() end },
    { '<C-Down>',  function() require('tmux').resize_bottom() end },
    { '<C-Left>',  function() require('tmux').resize_left() end },
    { '<C-Right>', function() require('tmux').resize_right() end },

    -- Tab switch buffer
    { '<S-h>',     ':BufferPrevious<CR>' },
    { '<S-l>',     ':BufferNext<CR>' },

    -- QuickFix
    { ']q',        ':cnext<CR>' },
    { '[q',        ':cprev<CR>' },
    { '<C-q>',     ':call QuickFixToggle()<CR>' },
    { '<F5>',      '<Esc>:w<CR>:exec "!python3" shellescape(@%, 1)<CR>' }
  },
  autocmds = {
    {
      'LspAttach',
      function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client.name == 'omnisharp' then
          client.server_capabilities.semanticTokensProvider = {
            full = vim.empty_dict(),
            legend = {
              tokenModifiers = { 'static_symbol' },
              tokenTypes = {
                'comment',
                'excluded_code',
                'identifier',
                'keyword',
                'keyword_control',
                'number',
                'operator',
                'operator_overloaded',
                'preprocessor_keyword',
                'string',
                'whitespace',
                'text',
                'static_symbol',
                'preprocessor_text',
                'punctuation',
                'string_verbatim',
                'string_escape_character',
                'class_name',
                'delegate_name',
                'enum_name',
                'interface_name',
                'module_name',
                'struct_name',
                'type_parameter_name',
                'field_name',
                'enum_member_name',
                'constant_name',
                'local_name',
                'parameter_name',
                'method_name',
                'extension_method_name',
                'property_name',
                'event_name',
                'namespace_name',
                'label_name',
                'xml_doc_comment_attribute_name',
                'xml_doc_comment_attribute_quotes',
                'xml_doc_comment_attribute_value',
                'xml_doc_comment_cdata_section',
                'xml_doc_comment_comment',
                'xml_doc_comment_delimiter',
                'xml_doc_comment_entity_reference',
                'xml_doc_comment_name',
                'xml_doc_comment_processing_instruction',
                'xml_doc_comment_text',
                'xml_literal_attribute_name',
                'xml_literal_attribute_quotes',
                'xml_literal_attribute_value',
                'xml_literal_cdata_section',
                'xml_literal_comment',
                'xml_literal_delimiter',
                'xml_literal_embedded_expression',
                'xml_literal_entity_reference',
                'xml_literal_name',
                'xml_literal_processing_instruction',
                'xml_literal_text',
                'regex_comment',
                'regex_character_class',
                'regex_anchor',
                'regex_quantifier',
                'regex_grouping',
                'regex_alternation',
                'regex_text',
                'regex_self_escaped_character',
                'regex_other_escape'
              }
            },
            range = true
          }
        end

        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
          require('notify')('Navic enabled', 'info', {
            title = 'LSP'
          })
        end

        require('notify')(client.name .. ': attached', 'info', {
          title = 'LSP'
        })

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)


        local mappings = {
          l = {
            name = 'LSP',
            D = { vim.lsp.buf.declaration, 'Declaration' },
            d = { vim.lsp.buf.definition, 'Definition' },
            K = { vim.lsp.buf.hover, 'Hover' },
            i = { vim.lsp.buf.implementation, 'Implementation' },
            k = { vim.lsp.buf.signature_help, 'Signature help' },
            t = { vim.lsp.buf.type_definition, 'Type definition' },
            r = { vim.lsp.buf.rename, 'Rename' },
            a = { vim.lsp.buf.code_action, 'Code action' },
            R = { vim.lsp.buf.references, 'References' },
            f = { function()
              mini_trailspace.trim()
              mini_trailspace.trim_last_lines()

              vim.lsp.buf.format { async = false }

              vim.api.nvim_command('write')
            end, 'Format' }
          },
          w = {
            name = 'Workspace',
            a = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
            r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
            l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List workspace folder' }
          }
        }

        local mappings_opts = {
          mode = 'n',
          prefix = '<leader>',
          -- Buffer local mappings.
          buffer = bufnr,
          silent = true,
          noremap = true,
          nowait = true
        }

        require('which-key').register(mappings, mappings_opts)
      end,
      description = 'Lsp Attach'
    }

    -- {
    --   'BufWritePre',
    --   function()
    --     mini_trailspace.trim()
    --     mini_trailspace.trim_last_lines()
    --
    --     vim.lsp.buf.format({ async = false })
    --   end,
    --   description = 'Format on save'
    -- }
  }
})
