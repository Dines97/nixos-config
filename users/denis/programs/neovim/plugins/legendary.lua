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
  }
})
