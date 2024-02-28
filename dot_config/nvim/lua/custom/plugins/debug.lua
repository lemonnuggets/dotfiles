return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'leoluz/nvim-dap-go',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',
  },
  config = function()
    require('nvim-dap-virtual-text').setup {}

    local dap = require 'dap'
    vim.keymap.set('n', '<F5>', function()
      dap.continue()
    end, { desc = 'Debug: Continue' })
    vim.keymap.set('n', '<F10>', function()
      dap.step_over()
    end, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', function()
      dap.step_into()
    end, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F12>', function()
      dap.step_out()
    end, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', function()
      dap.toggle_breakpoint()
    end, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>dl', function()
      dap.set_breakpoint(vim.fn.input(nil, nil, vim.fn.input 'Log point message: '))
    end, { desc = 'Debug: Set Log Point' })
    vim.keymap.set('n', '<leader>dr', function()
      dap.repl.open()
    end, { desc = 'Debug: Open REPL' })

    local dapui = require 'dapui'
    dapui.setup {}
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    local dap_go = require 'dap-go'
    dap_go.setup {}
    vim.keymap.set('n', '<leader>dt', function()
      dap_go.debug_test()
    end, { desc = 'Debug: Go Test' })
  end,
}
