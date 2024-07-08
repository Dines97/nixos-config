require('legendary').setup({
  extensions = {
    smart_splits = {}
  },
  keymaps = {
    -- Tab switch buffer
    { '<S-h>', ':BufferPrevious<CR>' },
    { '<S-l>', ':BufferNext<CR>' }
  }
})


-- require('nvim-lsp-endhints').setup({})
