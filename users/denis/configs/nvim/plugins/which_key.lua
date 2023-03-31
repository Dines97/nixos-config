local mappings = {
  f = {
    name = 'File', -- optional group name
    f = { '<cmd>Telescope find_files<cr>', 'Find File' }, -- create a binding with label
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File', noremap = false }, -- additional options for creating the keymap
    n = { 'New File' }, -- just a label. don't create any mapping
    e = 'Edit File', -- same as above
    ['1'] = 'which_key_ignore', -- special label to hide it in the popup
    b = { function() print('bar') end, 'Foobar' } -- you can also pass functions!
  },
  g = {
    name = 'Git',
    a = { '<cmd>Gwrite<cr>', 'Git add' },
    s = { '<cmd>Git<cr>', 'Git status' },
    p = { function() require('gitsigns').prev_hunk() end, 'Prev hunk' },
    n = { function() require('gitsigns').next_hunk() end, 'Next hunk' },
    h = { function() require('gitsigns').preview_hunk() end, 'Preview hunk' }
  },
  N = {
    name = 'Neovim',
    r = { '<cmd>luafile $MYVIMRC<cr>', 'Realod config' }
  },
  L = {
    name = 'LSP audit',
    i = { '<cmd>LspInfo<cr>', 'Info' },
    s = { '<cmd>LspStart<cr>', 'Start' },
    r = { '<cmd>LspRestart<cr>', 'Restart' },
    p = { '<cmd>LspStop<cr>', 'Stop' }
  },
  l = {
    name = 'LSP',
    c = { function() vim.diagnostic.open_float() end, 'Float' },
    l = { '<cmd>Trouble workspace_diagnostics<cr>', 'List' }

  },
  t = {
    name = 'Telescope',
    f = { function() require('telescope.builtin').find_files() end, 'Files' }
  },
  e = {
    name = 'Explorer',
    o = { '<cmd>Neotree source=filesystem reveal=true position=left toggle=true<cr>', 'Open' },
    f = { '<cmd>Neotree source=filesystem reveal=true position=float toggle=true<cr>', 'Float' }

  }
}

local mappings_opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true -- use `nowait` when creating keymaps
}

require('which-key').register(mappings, mappings_opts)
