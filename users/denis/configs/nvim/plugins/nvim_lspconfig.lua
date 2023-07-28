-- local configs = require('lspconfig.configs')
-- local util = require('lspconfig.util')

-- if not configs.helm_ls then
--   configs.helm_ls = {
--     default_config = {
--       cmd = { 'helm_ls', 'serve' },
--       filetypes = { 'helm' },
--       root_dir = function(fname)
--         return util.root_pattern('Chart.yaml')(fname)
--       end
--     }
--   }
-- end

local servers = {
  gopls = {},
  dockerls = {},
  -- helm_ls = {
  --   filetypes = { 'helm' },
  --   cmd = { 'helm_ls', 'serve' }
  -- },
  yamlls = {},
  pyright = {},
  hls = {},
  nil_ls = {},
  texlab = {},
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
  },
  terraformls = {},
  tflint = {}
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
