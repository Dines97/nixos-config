vim.g.mapleader = ' '

-- Required to fix empty which key screen
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 100

vim.opt.undofile = true

-- Required by notify
vim.opt.termguicolors = true

vim.opt.scrolloff = 5
vim.cmd('syntax on')
-- vim.cmd('set spell')
