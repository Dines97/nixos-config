local cfg = require('yaml-companion').setup({
  lspconfig = {
    capabilities = capabilities
  }
})

require('lspconfig')['yamlls'].setup(cfg)
