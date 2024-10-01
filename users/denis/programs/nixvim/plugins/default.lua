local function has_server_capability(bufnr, capability)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if client.server_capabilities[capability] then
      return true
    end
  end
  return false
end

require('legendary').setup({
  extensions = {
    smart_splits = {}
  },
  keymaps = {
    { '<S-Tab>',    '<cmd>BufferPrevious<cr>',                                                   mode = { 'n' },      description = 'Previous buffer' },
    { '<Tab>',      '<cmd>BufferNext<cr>',                                                       mode = { 'n' },      description = 'Next buffer' },

    { '<C-y>',      '"+y',                                                                       mode = { 'n', 'x' }, description = 'Copy to system clipboard' },
    { '<C-p>',      '"+p',                                                                       mode = { 'n', 'x' }, description = 'Paste from system clipboard' },

    { '<leader>eo', '<cmd>Neotree source=filesystem reveal=true position=left toggle=true<cr>',  mode = { 'n' },      description = 'Open' },
    { '<leader>ef', '<cmd>Neotree source=filesystem reveal=true position=float toggle=true<cr>', mode = { 'n' },      description = 'Float' },

    { '<leader>Li', '<cmd>LspInfo<cr>',                                                          mode = { 'n' },      description = 'Info' },
    { '<leader>Ls', '<cmd>LspStart<cr>',                                                         mode = { 'n' },      description = 'Start' },
    { '<leader>Lp', '<cmd>LspStop<cr>',                                                          mode = { 'n' },      description = 'Stop' },
    { '<leader>Lr', '<cmd>LspRestart<cr>',                                                       mode = { 'n' },      description = 'Restart' },

    { '<leader>tf', require('telescope.builtin').find_files,                                     mode = { 'n' },      description = 'Files' },
    { '<leader>tg', require('telescope.builtin').live_grep,                                      mode = { 'n' },      description = 'Grep' },
    { '<leader>tb', require('telescope.builtin').buffers,                                        mode = { 'n' },      description = 'Buffers' },
    { '<leader>tn', '<cmd>Telescope neoclip<cr>',                                                mode = { 'n' },      description = 'Neoclip' },

    -- vim.diagnostic
    { '<leader>de', vim.diagnostic.open_float,                                                   mode = { 'n' },      description = 'Open float' },
    { '<leader>dq', vim.diagnostic.setloclist,                                                   mode = { 'n' },      description = 'setloclist' },
    { '[d',         vim.diagnostic.goto_prev,                                                    mode = { 'n' },      description = 'Goto prev' },
    { ']d',         vim.diagnostic.goto_next,                                                    mode = { 'n' },      description = 'Goto next' },

    -- vim.lsp.buf
    { '<leader>lD', vim.lsp.buf.declaration,                                                     mode = { 'n' },      description = 'Declaration' },
    { '<leader>ld', vim.lsp.buf.definition,                                                      mode = { 'n' },      description = 'Definition' },
    { '<leader>li', vim.lsp.buf.implementation,                                                  mode = { 'n' },      description = 'Implementation' },
    { '<leader>lR', vim.lsp.buf.references,                                                      mode = { 'n' },      description = 'References' },
    { '<leader>lt', vim.lsp.buf.type_definition,                                                 mode = { 'n' },      description = 'Type definition' },
    { '<leader>lk', vim.lsp.buf.signature_help,                                                  mode = { 'n' },      description = 'Signature help' },
    { '<leader>lK', vim.lsp.buf.hover,                                                           mode = { 'n' },      description = 'Hover' },
    { '<leader>lr', vim.lsp.buf.rename,                                                          mode = { 'n' },      description = 'Rename' },
    { '<leader>la', vim.lsp.buf.code_action,                                                     mode = { 'n' },      description = 'Code action' },
    {
      '<leader>lf',
      function()
        -- Needs to be async false or format could happen after write
        vim.lsp.buf.format { async = false }
        vim.api.nvim_command('write')
      end,
      mode = { 'n' },
      description = 'Format'
    },
    {
      '<leader>lv',
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      mode = { 'n' },
      description = 'Toggle inlay hint'
    },

    -- workspace
    { '<leader>wa', vim.lsp.buf.add_workspace_folder,    mode = { 'n' }, description = 'Add workspace folder' },
    { '<leader>wr', vim.lsp.buf.remove_workspace_folder, mode = { 'n' }, description = 'Remove workspace folder' },
    {
      '<leader>wl',
      function()
        vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      mode = { 'n' },
      description = 'List workspace folder'
    }
  },
  autocmds = {
    {
      'BufWritePre',
      function()
        local mini_trailspace = require('mini.trailspace')
        mini_trailspace.trim()
        mini_trailspace.trim_last_lines()

        -- local curpos = vim.api.nvim_win_get_cursor(0)
        -- -- TODO: Check this regex for correctnes
        -- vim.cmd([[keeppatterns %s/\%$/\r/e]])
        -- vim.api.nvim_win_set_cursor(0, curpos)

        local n_lines = vim.api.nvim_buf_line_count(0)
        local last_nonblank = vim.fn.prevnonblank(n_lines)
        vim.api.nvim_buf_set_lines(0, last_nonblank, last_nonblank, true, { '' })
      end,
      description = 'Trim whitespaces but keep one empty line at the end of file'
    } }
})

-- require('nvim-lsp-endhints').setup({})

