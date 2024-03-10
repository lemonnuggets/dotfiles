return {
  'leoluz/nvim-dap-go',
  ft = { 'go' }, -- REQUIRED for all in dap-langs
  dependencies = {
    'mfussenegger/nvim-dap', -- REQUIRED for all in dap-langs
  },
  config = function()
    local dap = require 'dap' -- REQUIRED for all in dap-langs

    local dap_go = require 'dap-go'
    dap_go.setup {}
    vim.keymap.set('n', '<leader>dt', function()
      dap_go.debug_test()
    end, { desc = 'Debug: Go Test' })
  end,
}
