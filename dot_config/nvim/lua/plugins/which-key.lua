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
  config = function()
    local whichkey = require 'which-key'
    whichkey.register {
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>gh'] = { name = '[H]unk', _ = 'which_key_ignore' },
      ['<leader>gt'] = { name = '[T]oggle', _ = 'which_key_ignore' },
    }

    whichkey.register({
      ['<leader>'] = { name = 'VISUAL <leader>' },
      ['<leader>g'] = { '[G]it' },
      ['<leader>gh'] = { 'Git [H]unk' },
    }, { mode = 'v' })
  end,
}
