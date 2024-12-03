-- -- this is to fix bug: https://github.com/folke/which-key.nvim/issues/476
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set up conjure Which-Key descriptions',
  group = vim.api.nvim_create_augroup('conjure_mapping_descriptions', { clear = true }),
  pattern = { 'clojure' },
  callback = function()
    vim.keymap.set('n', '<localleader>', function()
      require('which-key').show '\\'
    end, { buffer = true })
  end,
})

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    icons = {
      mappings = false,
    },
  },
  spec = {
    { '<leader>', group = 'VISUAL <leader>', mode = { 'n', 'v' } },
    { '<leader>s', group = '[S]earch' },
    { '<leader>c', group = '[C]ode', mode = { 'n', 'v' } },
    { '<leader>r', group = '[R]ename' },
    { '<leader>d', group = '[D]ebug' },
    { '<leader>w', group = '[W]orkspace' },

    { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
    { '<leader>gh', group = '[G]it [H]unk', mode = { 'n', 'v' } },
    { '<leader>gt', group = '[G]it [T]oggle' },
  },
  -- config = function()
  --   local whichkey = require 'which-key'
  --   whichkey.register
  -- end,
}
