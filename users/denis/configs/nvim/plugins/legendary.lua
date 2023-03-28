require('legendary').setup({
  keymaps = {
    -- Better window movement
    -- ["<C-h>"] = "<C-w>h",
    -- ["<C-j>"] = "<C-w>j",
    -- ["<C-k>"] = "<C-w>k",
    -- ["<C-l>"] = "<C-w>l",
    --
    -- Resize with arrows
    { '<C-Up>', function() require('tmux').resize_top() end },
    { '<C-Down>', function() require('tmux').resize_bottom() end },
    { '<C-Left>', function() require('tmux').resize_left() end },
    { '<C-Right>', function() require('tmux').resize_right() end },

    -- Tab switch buffer
    { '<S-l>', ':BufferLineCycleNext<CR>' },
    { '<S-h>', ':BufferLineCyclePrev<CR>' },

    -- QuickFix
    { ']q', ':cnext<CR>' },
    { '[q', ':cprev<CR>' },
    { '<C-q>', ':call QuickFixToggle()<CR>' },
    { '<F5>', '<Esc>:w<CR>:exec "!python3" shellescape(@%, 1)<CR>' }
  },
  autocmds = {
    { 'LspAttach', function(ev)

      require('notify')('LSP attached')

      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', '<space>lD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', '<space>ld', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<space>lK', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<space>li', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
      vim.keymap.set('n', '<space>lD', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<space>lR', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, opts)
    end, description = 'Lsp Attach' },
    { 'BufWritePre', function() vim.lsp.buf.format({ async = false }) end, description = 'Format on save' }
  }
})
