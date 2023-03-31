require('legendary').setup({
  keymaps = {
    -- Better window movement
    -- ["<C-h>"] = "<C-w>h",
    -- ["<C-j>"] = "<C-w>j",
    -- ["<C-k>"] = "<C-w>k",
    -- ["<C-l>"] = "<C-w>l",
    --
    -- Resize with arrows
    { '<C-Up>',    function() require('tmux').resize_top() end },
    { '<C-Down>',  function() require('tmux').resize_bottom() end },
    { '<C-Left>',  function() require('tmux').resize_left() end },
    { '<C-Right>', function() require('tmux').resize_right() end },

    -- Tab switch buffer
    { '<S-h>',     ':BufferPrevious<CR>' },
    { '<S-l>',     ':BufferNext<CR>' },

    -- QuickFix
    { ']q',        ':cnext<CR>' },
    { '[q',        ':cprev<CR>' },
    { '<C-q>',     ':call QuickFixToggle()<CR>' },
    { '<F5>',      '<Esc>:w<CR>:exec "!python3" shellescape(@%, 1)<CR>' }
  },
  autocmds = {
    {
      'LspAttach',
      function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        require('notify')(client.name .. ': attached', 'info', {
          title = 'LSP'
        })

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local mappings = {
          l = {
            name = 'LSP',
            D = { vim.lsp.buf.declaration, 'Declaration' },
            d = { vim.lsp.buf.definition, 'Definition' },
            K = { vim.lsp.buf.hover, 'Hover' },
            i = { vim.lsp.buf.implementation, 'Implementation' },
            k = { vim.lsp.buf.signature_help, 'Signature help' },
            t = { vim.lsp.buf.type_definition, 'Type definition' },
            r = { vim.lsp.buf.rename, 'Rename' },
            a = { vim.lsp.buf.code_action, 'Code action' },
            R = { vim.lsp.buf.references, 'References' },
            f = { function() vim.lsp.buf.format { async = true } end, 'Format' }
          },
          w = {
            name = 'Workspace',
            a = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
            r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
            l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List workspace folder' }
          }
        }

        local mappings_opts = {
          mode = 'n',
          prefix = '<leader>',
          -- Buffer local mappings.
          buffer = ev.buf,
          silent = true,
          noremap = true,
          nowait = true
        }

        require('which-key').register(mappings, mappings_opts)
      end,
      description = 'Lsp Attach'
    },

    {
      'BufWritePre',
      function()
        local mini_trailspace = require('mini.trailspace')
        mini_trailspace.trim()
        mini_trailspace.trim_last_lines()

        vim.lsp.buf.format({ async = false })
      end,
      description = 'Format on save'
    }
  }
})
