local null_ls = require('null-ls')

null_ls.register({
  sources = {
    null_ls.builtins.formatting.alejandra
  }
})

require('lspconfig')['nil_ls'].setup({
  capabilities = capabilities
})

-- require('lspconfig')['rnix'].setup({
--   capabilities = capabilities
-- })
