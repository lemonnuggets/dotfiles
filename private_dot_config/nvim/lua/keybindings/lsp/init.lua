-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local keymap = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }
keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

