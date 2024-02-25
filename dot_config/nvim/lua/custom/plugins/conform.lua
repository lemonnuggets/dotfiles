local formatters = require 'custom.config.formatters'
local slow_format_filetypes = {}
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
  },
  init = function()
    local conform = require 'conform'
    conform.setup {
      formatters_by_ft = formatters,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end

        local function on_format(err)
          if err and err:match 'timeout$' then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end

        return { timeout_ms = 500, lsp_fallback = true }, on_format
      end,
      format_after_save = function(bufnr)
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return {
          lsp_fallback = true,
        }
      end,
      -- Customize formatters
      formatters = {},
    }

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = { start = { args.line1, 0 }, ['end'] = { args.line2, end_line:len() } }
      end
      require('conform').format { async = true, lsp_fallback = true, range = range }
    end, { range = true })

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save (! for only buffer)',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    vim.api.nvim_create_user_command('FormatDiff', function()
      local lines = vim.fn.system('git diff --unified=0'):gmatch '[^\n\r]+'
      local ranges = {}
      for line in lines do
        if line:find '^@@' then
          local line_nums = line:match '%+.- '
          if line_nums:find ',' then
            local _, _, first, second = line_nums:find '(%d+),(%d+)'
            table.insert(ranges, {
              start = { tonumber(first), 0 },
              ['end'] = { tonumber(first) + tonumber(second), 0 },
            })
          else
            local first = tonumber(line_nums:match '%d+')
            table.insert(ranges, {
              start = { first, 0 },
              ['end'] = { first + 1, 0 },
            })
          end
        end
      end
      local format = require('conform').format
      for _, range in pairs(ranges) do
        format {
          range = range,
        }
      end
    end, { desc = 'Format changed lines' })
  end,
}
