local function debounce(ms, fn)
  local timer = vim.loop.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

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
      'BufWritePost',
      'BufReadPost',
      'InsertLeave',
    }, {
      group = lint_augroup,
      callback = debounce(10, function()
        lint.try_lint()
      end),
    })
  end,
}
