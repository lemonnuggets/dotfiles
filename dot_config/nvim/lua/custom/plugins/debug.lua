return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    vim.keymap.set('n', '<leader>dd', function()
      dap.continue()
    end, { desc = 'Debug: Continue' })
    vim.keymap.set('n', '<leader>do', function()
      dap.step_over()
    end, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>di', function()
      dap.step_into()
    end, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>dO', function()
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

    require('nvim-dap-virtual-text').setup {}

    -------------------- Language Specific Config --------------------

    ---------- golang ----------

    local dap_go = require 'dap-go'
    dap_go.setup {}
    vim.keymap.set('n', '<leader>dt', function()
      dap_go.debug_test()
    end, { desc = 'Debug: Go Test' })

    ---------- javascript ----------

    local js_based_languages = {
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
      'vue',
    }
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        }, -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch & Debug Chrome',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = 'Enter URL: ',
                default = 'http://localhost:3000',
              }, function(url)
                if url == nil or url == '' then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = 'inspector',
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs
        {
          name = '----- ↓ launch.json configs ↓ -----',
          type = '',
          request = 'launch',
        },
      }
    end

    vim.keymap.set('n', '<leader>da', function()
      if vim.fn.filereadable '.vscode/launch.json' then
        local dap_vscode = require 'dap.ext.vscode'
        dap_vscode.load_launchjs(nil, {
          ['pwa-node'] = js_based_languages,
          ['chrome'] = js_based_languages,
          ['pwa-chrome'] = js_based_languages,
        })
      end
      require('dap').continue()
    end, { desc = 'Debug(js): Run with args' })
  end,
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',
    'leoluz/nvim-dap-go',
    {
      'microsoft/vscode-js-debug',
      build = 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
      version = '1.*',
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        require('dap-vscode-js').setup {
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = {
            'chrome',
            'pwa-node',
            'pwa-chrome',
            'pwa-msedge',
            'pwa-extensionHost',
            'node-terminal',
          },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

          -- Logging level for output to file. Set to false to disable logging.
          -- log_file_level = false,

          -- Logging level for output to console. Set to false to disable console output.
          -- log_console_level = vim.log.levels.ERROR,
        }
      end,
    },
    {
      -- used to parse launch.json if it exists
      'Joakker/lua-json5',
      build = './install.sh',
    },
  },
}
