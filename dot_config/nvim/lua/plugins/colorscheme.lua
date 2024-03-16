-- return {
--   'catppuccin/nvim',
--   name = 'catppuccin',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'catppuccin-mocha'
--   end,
-- }

-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function()
--     vim.cmd.colorscheme 'tokyonight-moon'
--   end,
-- }

return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    vim.o.background = 'dark' -- or "light" for light mode
    vim.cmd.colorscheme 'gruvbox'
  end,
}
