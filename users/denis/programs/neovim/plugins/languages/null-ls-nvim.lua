local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.vale

    null_ls.builtins.formatting.prettier.with({
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'css', 'scss', 'less', 'html', 'json', 'jsonc', 'yaml', 'markdown', 'markdown.mdx', 'graphql', 'handlebars', 'toml' }
    })
  }
})
