require('kubectl').setup({})
-- default mappings
local group = vim.api.nvim_create_augroup('kubectl_mappings', { clear = false })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = 'k8s_*',
  callback = function(ev)
    vim.notify('k8s autocmd')

    local opts = { buffer = ev.buf }

    -- Global
    vim.keymap.set('n', '<leader>kh', '<Plug>(kubectl.help)', opts) -- Help float
    -- k('n', 'gr', '<Plug>(kubectl.refresh)', opts)           -- Refresh view
    -- k('n', 'gs', '<Plug>(kubectl.sort)', opts)              -- Sort by column
    -- k('n', 'gD', '<Plug>(kubectl.delete)', opts)            -- Delete resource
    -- k('n', 'gd', '<Plug>(kubectl.describe)', opts)          -- Describe resource
    -- k('n', 'ge', '<Plug>(kubectl.edit)', opts)              -- Edit resource
    -- k('n', '<C-l>', '<Plug>(kubectl.filter_label)', opts)   -- Filter labels
    -- k('n', '<BS>', '<Plug>(kubectl.go_up)', opts)           -- Go back to previous view
    -- k('v', '<C-f>', '<Plug>(kubectl.filter_term)', opts)    -- Filter selected text
    -- k('n', '<CR>', '<Plug>(kubectl.select)', opts)          -- Resource select action (different on each view)
    -- k('n', '<Tab>', '<Plug>(kubectl.tab)', opts)            -- Tab completion (ascending, when applicable)
    -- k('n', '<Tab>', '<Plug>(kubectl.shift_tab)', opts)      -- Tab completion (descending, when applicable)
    -- k('n', '', '<Plug>(kubectl.quit)', opts)                -- Close view (when applicable)
    -- k('n', 'gk', '<Plug>(kubectl.kill)', opts)              -- Pod/portforward kill
    -- k('n', '<M-h>', '<Plug>(kubectl.toggle_headers)', opts) -- Toggle headers
    --
    -- -- Views
    -- k('n', '<C-a>', '<Plug>(kubectl.alias_view)', opts)         -- Aliases view
    -- k('n', '<C-x>', '<Plug>(kubectl.contexts_view)', opts)      -- Contexts view
    -- k('n', '<C-f>', '<Plug>(kubectl.filter_view)', opts)        -- Filter view
    -- k('n', '<C-n>', '<Plug>(kubectl.namespace_view)', opts)     -- Namespaces view
    -- k('n', 'gP', '<Plug>(kubectl.portforwards_view)', opts)     -- Portforwards view
    -- k('n', '1', '<Plug>(kubectl.view_deployments)', opts)       -- Deployments view
    -- k('n', '2', '<Plug>(kubectl.view_pods)', opts)              -- Pods view
    -- k('n', '3', '<Plug>(kubectl.view_configmaps)', opts)        -- ConfigMaps view
    -- k('n', '4', '<Plug>(kubectl.view_secrets)', opts)           -- Secrets view
    -- k('n', '5', '<Plug>(kubectl.view_services)', opts)          -- Services view
    -- k('n', '6', '<Plug>(kubectl.view_ingresses)', opts)         -- Ingresses view
    -- k('n', '', '<Plug>(kubectl.view_api_resources)', opts)      -- API-Resources view
    -- k('n', '', '<Plug>(kubectl.view_clusterrolebinding)', opts) -- ClusterRoleBindings view
    -- k('n', '', '<Plug>(kubectl.view_crds)', opts)               -- CRDs view
    -- k('n', '', '<Plug>(kubectl.view_cronjobs)', opts)           -- CronJobs view
    -- k('n', '', '<Plug>(kubectl.view_daemonsets)', opts)         -- DaemonSets view
    -- k('n', '', '<Plug>(kubectl.view_events)', opts)             -- Events view
    -- k('n', '', '<Plug>(kubectl.view_helm)', opts)               -- Helm view
    -- k('n', '', '<Plug>(kubectl.view_jobs)', opts)               -- Jobs view
    -- k('n', '', '<Plug>(kubectl.view_nodes)', opts)              -- Nodes view
    -- k('n', '', '<Plug>(kubectl.view_overview)', opts)           -- Overview view
    -- k('n', '', '<Plug>(kubectl.view_pv)', opts)                 -- PersistentVolumes view
    -- k('n', '', '<Plug>(kubectl.view_pvc)', opts)                -- PersistentVolumeClaims view
    -- k('n', '', '<Plug>(kubectl.view_sa)', opts)                 -- ServiceAccounts view
    -- k('n', '', '<Plug>(kubectl.view_top_nodes)', opts)          -- Top view for nodes
    -- k('n', '', '<Plug>(kubectl.view_top_pods)', opts)           -- Top view for pods
    --
    -- -- Deployment/DaemonSet actions
    -- k('n', 'grr', '<Plug>(kubectl.rollout_restart)', opts) -- Rollout restart
    -- k('n', 'gss', '<Plug>(kubectl.scale)', opts)           -- Scale workload
    -- k('n', 'gi', '<Plug>(kubectl.set_image)', opts)        -- Set image (only if 1 container)
    --
    -- -- Pod/Container logs
    -- k('n', 'gl', '<Plug>(kubectl.logs)', opts)           -- Logs view
    -- k('n', 'gh', '<Plug>(kubectl.history)', opts)        -- Change logs --since= flag
    -- k('n', 'f', '<Plug>(kubectl.follow)', opts)          -- Follow logs
    -- k('n', 'gw', '<Plug>(kubectl.wrap)', opts)           -- Toggle wrap log lines
    -- k('n', 'gp', '<Plug>(kubectl.prefix)', opts)         -- Toggle container name prefix
    -- k('n', 'gt', '<Plug>(kubectl.timestamps)', opts)     -- Toggle timestamps prefix
    -- k('n', 'gpp', '<Plug>(kubectl.previous_logs)', opts) -- Toggle show previous logs
    --
    -- -- Node actions
    -- k('n', 'gC', '<Plug>(kubectl.cordon)', opts)   -- Cordon node
    -- k('n', 'gU', '<Plug>(kubectl.uncordon)', opts) -- Uncordon node
    -- k('n', 'gR', '<Plug>(kubectl.drain)', opts)    -- Drain node
    --
    -- -- Top actions
    -- k('n', 'gn', '<Plug>(kubectl.top_nodes)', opts) -- Top nodes
    -- k('n', 'gp', '<Plug>(kubectl.top_pods)', opts)  -- Top pods
    --
    -- -- CronJob/Job actions
    -- k('n', 'gx', '<Plug>(kubectl.suspend_job)', opts) -- only for CronJob
    -- k('n', 'gc', '<Plug>(kubectl.create_job)', opts)  -- Create Job from CronJob or Job
    --
    -- k('n', 'gp', '<Plug>(kubectl.portforward)', opts) -- Pods/Services portforward
    -- k('n', 'gx', '<Plug>(kubectl.browse)', opts)      -- Ingress view
    -- k('n', 'gy', '<Plug>(kubectl.yaml)', opts)        -- Helm view
  end
})

require('grug-far').setup({})

require('pest-vim').setup({})

require('satellite').setup({})

local function has_server_capability(bufnr, capability)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if client.server_capabilities[capability] then
      return true
    end
  end
  return false
end

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Local leader triggers
    { mode = 'n', keys = '<localleader>' },
    { mode = 'x', keys = '<localleader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' }
  },

  clues = {
    { mode = 'n', keys = '<leader>l',  desc = '+LSP' },
    { mode = 'n', keys = '<leader>L',  desc = '+LSP audit' },
    { mode = 'n', keys = '<leader>r',  desc = '+Trouble' },
    { mode = 'n', keys = '<leader>w',  desc = '+Workspace' },
    { mode = 'n', keys = '<leader>d',  desc = '+Diagnostic' },
    { mode = 'n', keys = '<leader>t',  desc = '+Telescope' },
    { mode = 'n', keys = '<leader>e',  desc = '+Explorer' },
    { mode = 'n', keys = '<leader>b',  desc = '+Buffer' },

    { mode = 'n', keys = '<leader>f',  desc = '+Language' },
    { mode = 'n', keys = '<leader>fr', desc = '+Rust' },

    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z()
  },

  window = { delay = 0 }
})

require('legendary').setup({
  extensions = {
    smart_splits = {}
  },
  keymaps = {
    -- buffer
    { '<S-Tab>',     '<cmd>BufferPrevious<cr>',                                                   mode = { 'n' },      description = 'Previous buffer' },
    { '<Tab>',       '<cmd>BufferNext<cr>',                                                       mode = { 'n' },      description = 'Next buffer' },
    { '<leader>bc',  '<cmd>BufferClose<cr>',                                                      mode = { 'n' },      description = 'Close' },
    { '<leader>bb',  '<cmd>BufferCloseAllButCurrent<cr>',                                         mode = { 'n' },      description = 'Close but current' },
    { '<leader>bv',  '<cmd>BufferCloseAllButVisible<cr>',                                         mode = { 'n' },      description = 'Close but visible' },

    -- rust
    { '<leader>frr', '<cmd>RustAnalyzer restart<cr>',                                             mode = { 'n' },      description = 'Rust analyzer restart' },
    { '<leader>fre', '<cmd>RustLsp expandMacro<cr>',                                              mode = { 'n' },      description = 'Rust lsp expandMacro' },

    -- registers
    { '<C-y>',       '"+y',                                                                       mode = { 'n', 'x' }, description = 'Copy to system clipboard' },
    { '<C-p>',       '"+p',                                                                       mode = { 'n', 'x' }, description = 'Paste from system clipboard' },

    -- explorer
    { '<leader>eo',  '<cmd>Neotree source=filesystem reveal=true toggle=true position=left<cr>',  mode = { 'n' },      description = 'Open' },
    { '<leader>ef',  '<cmd>Neotree source=filesystem reveal=true toggle=true position=float<cr>', mode = { 'n' },      description = 'Float' },
    { '<leader>em',  require('mini.files').open,                                                  mode = { 'n' },      description = 'MiniFiles' },
    { '<leader>ei',  '<cmd>Oil<cr>',                                                              mode = { 'n' },      description = 'Oil' },

    -- lsp audit
    { '<leader>Li',  '<cmd>LspInfo<cr>',                                                          mode = { 'n' },      description = 'Info' },
    { '<leader>Ls',  '<cmd>LspStart<cr>',                                                         mode = { 'n' },      description = 'Start' },
    { '<leader>Lp',  '<cmd>LspStop<cr>',                                                          mode = { 'n' },      description = 'Stop' },
    { '<leader>Lr',  '<cmd>LspRestart<cr>',                                                       mode = { 'n' },      description = 'Restart' },

    -- telescope
    { '<leader>tf',  require('telescope.builtin').find_files,                                     mode = { 'n' },      description = 'Files' },
    { '<leader>tg',  require('telescope.builtin').live_grep,                                      mode = { 'n' },      description = 'Grep' },
    { '<leader>tb',  require('telescope.builtin').buffers,                                        mode = { 'n' },      description = 'Buffers' },
    { '<leader>tc',  require('telescope.builtin').commands,                                       mode = { 'n' },      description = 'Commands' },
    { '<leader>th',  require('telescope.builtin').command_history,                                mode = { 'n' },      description = 'Command history' },
    { '<leader>tn',  '<cmd>Telescope neoclip<cr>',                                                mode = { 'n' },      description = 'Neoclip' },

    -- snacks.nvim
    { '<leader>sf',  Snacks.picker.files,                                                         mode = { 'n' },      description = 'Files' },
    { '<leader>sg',  Snacks.picker.grep,                                                          mode = { 'n' },      description = 'Grep' },
    { '<leader>sb',  Snacks.picker.buffers,                                                       mode = { 'n' },      description = 'Buffers' },
    { '<leader>sc',  Snacks.picker.commands,                                                      mode = { 'n' },      description = 'Commands' },
    { '<leader>sh',  Snacks.picker.command_history,                                               mode = { 'n' },      description = 'Command history' },
    { '<leader>ss',  Snacks.picker.lsp_symbols,                                                   mode = { 'n' },      description = 'LSP Symbols' },
    { '<leader>sS',  Snacks.picker.lsp_workspace_symbols,                                         mode = { 'n' },      description = 'LSP Workspace Symbols' },



    -- vim.diagnostic
    { '<leader>de',  vim.diagnostic.open_float,                                                   mode = { 'n' },      description = 'Open float' },
    { '<leader>dq',  vim.diagnostic.setloclist,                                                   mode = { 'n' },      description = 'setloclist' },
    { '[d',          vim.diagnostic.goto_prev,                                                    mode = { 'n' },      description = 'Goto prev' },
    { ']d',          vim.diagnostic.goto_next,                                                    mode = { 'n' },      description = 'Goto next' },

    -- vim.lsp.buf
    { '<leader>lD',  vim.lsp.buf.declaration,                                                     mode = { 'n' },      description = 'Declaration' },
    { '<leader>ld',  vim.lsp.buf.definition,                                                      mode = { 'n' },      description = 'Definition' },
    { '<leader>li',  vim.lsp.buf.implementation,                                                  mode = { 'n' },      description = 'Implementation' },
    { '<leader>lR',  vim.lsp.buf.references,                                                      mode = { 'n' },      description = 'References' },
    { '<leader>lt',  vim.lsp.buf.type_definition,                                                 mode = { 'n' },      description = 'Type definition' },
    { '<leader>lk',  vim.lsp.buf.signature_help,                                                  mode = { 'n' },      description = 'Signature help' },
    { '<leader>lK',  vim.lsp.buf.hover,                                                           mode = { 'n' },      description = 'Hover' },
    { '<leader>lr',  vim.lsp.buf.rename,                                                          mode = { 'n' },      description = 'Rename' },
    { '<leader>la',  vim.lsp.buf.code_action,                                                     mode = { 'n' },      description = 'Code action' },
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
    -- {
    --   name = 'kubectl_mappings',
    --   clear = false,
    --   {
    --     'FileType',
    --     function(ev)
    --     end,
    --     opts = {
    --       pattern = { 'k8s_*' }
    --     },
    --     description = 'kubectl.nvim keymaps'
    --   }
    -- },
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
        if last_nonblank > 0 then
          vim.api.nvim_buf_set_lines(0, last_nonblank, last_nonblank, true, { '' })
        end
      end,
      description = 'Trim whitespaces but keep one empty line at the end of file'
    }
  }
})

-- require('nvim-lsp-endhints').setup({})

