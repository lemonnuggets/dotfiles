-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })     --leader key
vim.g.mapleader=' '
vim.g.maplocalleader=' '

--clear search highlighting
keymap('n', '<leader>ll', '<cmd>noh<CR>', {})

--save file
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<ESC>:w<CR>a', {})

--move between windows
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-l>", "<c-w>l", opts)

--resize windows
keymap("n", "<c-up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<c-down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<c-left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<c-right>", "<cmd>vertical resize +2<CR>", opts)

--quick exit insert mode
--keymap("i", "jk", "<ESC>", opts)

--stay in visual mode while indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

--move selected block vertically
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "p", "_dP", opts)   --when pasting into selected area, doesn't copy overwritten text into buffer

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

require('keybindings.nvim-tree-config')
require('keybindings.barbar-config')
require('keybindings.telescope-config')
