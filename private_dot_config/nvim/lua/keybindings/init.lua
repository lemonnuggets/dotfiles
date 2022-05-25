--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })     --leader key
vim.g.mapleader=' '
vim.g.maplocalleader=' '

vim.keymap.set('n', '<c-s>', ':w<CR>', {})
vim.keymap.set('i', '<c-s>', '<ESC>:w<CR>a', {})

require('keybindings.nvim-tree-config')
