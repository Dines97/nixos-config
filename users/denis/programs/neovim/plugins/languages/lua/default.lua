require('lspconfig')['lua_ls'].setup({
  capabilities = capabilities,
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
})
