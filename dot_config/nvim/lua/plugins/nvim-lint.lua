return {
  'mfussenegger/nvim-lint',
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    -- required so nvim env includes linters installed by mason
    local mason = require 'mason'
    mason.setup()

    local lint = require 'lint'
    local linters = require 'config.linters'
    lint.linters_by_ft = linters

    local lint_augroup = vim.api.nvim_create_augroup('lint', {
      clear = true,
    })

    vim.api.nvim_create_autocmd({
      'BufEnter',
      'BufWritePost',
      'InsertLeave',
    }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
