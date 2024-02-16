require('lspconfig')['volar'].setup({
  capabilities = capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  init_options = {
    typescript = {
      tsdk = '/etc/profiles/per-user/denis/lib/node_modules/typescript/lib'
    }
  }
})

require('lspconfig')['vuels'].setup({
  capabilities = capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
})
