require('lspconfig')['omnisharp'].setup({
  capabilities = capabilities,
  cmd = { 'OmniSharp' },
  handlers = {
    ['textDocument/definition'] = require('omnisharp_extended').handler
  }
})
