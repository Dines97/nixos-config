-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local mini_trailspace = require('mini.trailspace')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
require('which-key').register({
  ['<leader>l'] = {
    e = { vim.diagnostic.open_float, 'Open float' },
    q = { vim.diagnostic.setloclist, 'Add buffer diagnostics to the location list' }
  },
  ['[d'] = { vim.diagnostic.goto_prev, 'Diagnostics: goto prev' },
  [']d'] = { vim.diagnostic.goto_next, 'Diagnostics: goto next' }
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  desc = 'LSP Attach',
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    require('virtualtypes').on_attach()
    require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)

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

    vim.notify(client.name .. ': attached', vim.log.levels.INFO, { title = 'LSP' })

    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, bufnr)
      vim.notify('Navic enabled', vim.log.levels.INFO, { title = 'LSP' })
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

    -- Normal mode
    local normal_mappings = {
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

          -- Needs to be async false or format could happend after write
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
    local normal_mappings_opts = {
      mode = 'n',
      prefix = '<leader>',
      -- Buffer local mappings.
      buffer = bufnr
    }
    require('which-key').register(normal_mappings, normal_mappings_opts)

    -- Visual mode
    local visual_mappings = {
      l = {
        name = 'LSP',
        a = { vim.lsp.buf.code_action, 'Code action' }
      }
    }
    local visual_mappings_opts = {
      mode = 'v',
      prefix = '<leader>',
      -- Buffer local mappings.
      buffer = bufnr
    }
    require('which-key').register(visual_mappings, visual_mappings_opts)
  end
})

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   desc = 'Format on save',
--   callback = function()
--     mini_trailspace.trim()
--     mini_trailspace.trim_last_lines()
--
--     vim.lsp.buf.format({ async = true })
--   end
-- })
