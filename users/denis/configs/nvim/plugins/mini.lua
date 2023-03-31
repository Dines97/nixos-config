-- Each module need to be setup seperatly to it to take effect

-- Comment.nvim prefered because of block comment in nix
-- require('mini.comment').setup()

-- Underline same words
require('mini.cursorword').setup()

-- Move selected text with alt+hjkl
require('mini.move').setup()

-- Remove trailing whitespaces
require('mini.trailspace').setup()
