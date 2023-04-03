local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.diagnostics.vale

    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.alejandra

  }
})