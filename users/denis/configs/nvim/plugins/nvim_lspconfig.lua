local servers = {
  gopls = {},
  dockerls = {},
  yamlls = require('yaml-companion').setup(),
  pyright = {},
  hls = {},
  nil_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = {
            '/run/current-system/sw/share/awesome/lib'
          }
        },
        diagnostics = {
          globals = { 'vim' }
        },
        format = {
          enable = true,
          -- Put format options here
          -- NOTE: the value should be STRING!!
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
            quote_style = 'single',
            trailing_table_separator = 'never'
          }
        }
      }
    }
  },
  omnisharp = {
    cmd = { 'OmniSharp' },
    handlers = {
      ['textDocument/definition'] = require('omnisharp_extended').handler
    }
  }
  -- volar = {
  --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
  -- },
  -- vuels = {
  --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
  -- },
  -- rnix = {},
  -- jedi_language_server = {}
}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


for server, opts in pairs(servers) do
  opts.capabilities = capabilities
  lspconfig[server].setup(opts)
end
