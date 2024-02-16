require('lspconfig')['yamlls'].setup(
  require('yaml-companion').setup({
    capabilities = capabilities
  })
)
