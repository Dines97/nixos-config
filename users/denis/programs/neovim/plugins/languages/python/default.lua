require('lspconfig')['pyright'].setup({
  capabilities = capabilities
})

-- require('lspconfig')['jedi_language_server'].setup({
--   capabilities = capabilities
-- })
--
local null_ls = require('null-ls')

null_ls.register({
  sources = {
    null_ls.builtins.formatting.isort,
    -- null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.black
  }
})
