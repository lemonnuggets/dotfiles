function show_only_one_sign_in_sign_column()
  ---custom namespace
  local ns = vim.api.nvim_create_namespace 'severe-diagnostics'

  ---reference to the original handler
  local orig_signs_handler = vim.diagnostic.handlers.signs

  ---Overriden diagnostics signs helper to only show the single most relevant sign
  ---@see `:h diagnostic-handlers`
  vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
      -- get all diagnostics from the whole buffer rather
      -- than just the diagnostics passed to the handler
      local diagnostics = vim.diagnostic.get(bufnr)

      local filtered_diagnostics = filter_diagnostics(diagnostics)

      -- pass the filtered diagnostics (with the
      -- custom namespace) to the original handler
      orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
    end,

    hide = function(_, bufnr)
      orig_signs_handler.hide(ns, bufnr)
    end,
  }

  filter_diagnostics = function(diagnostics)
    if not diagnostics then
      return {}
    end

    -- find the "worst" diagnostic per line
    local most_severe = {}
    for _, cur in pairs(diagnostics) do
      local max = most_severe[cur.lnum]

      -- higher severity has lower value (`:h diagnostic-severity`)
      if not max or cur.severity < max.severity then
        most_severe[cur.lnum] = cur
      end
    end

    -- return list of diagnostics
    return vim.tbl_values(most_severe)
  end
end

return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    -- sign_priority = 100,
    on_attach = function(bufnr)
      -- show_only_one_sign_in_sign_column()
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Jump to next hunk' })

      map({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Jump to previous hunk' })

      -- Actions
      -- visual mode
      map('v', '<leader>ghs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'stage git hunk' })
      map('v', '<leader>ghr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'reset git hunk' })
      -- normal mode
      map('n', '<leader>ghs', gs.stage_hunk, { desc = 'git stage hunk' })
      map('n', '<leader>ghr', gs.reset_hunk, { desc = 'git reset hunk' })
      map('n', '<leader>ghS', gs.stage_buffer, { desc = 'git Stage buffer' })
      map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
      map('n', '<leader>ghR', gs.reset_buffer, { desc = 'git Reset buffer' })
      map('n', '<leader>ghp', gs.preview_hunk, { desc = 'preview git hunk' })
      map('n', '<leader>ghb', function()
        gs.blame_line { full = false }
      end, { desc = 'git blame line' })
      map('n', '<leader>ghd', gs.diffthis, { desc = 'git diff against index' })
      map('n', '<leader>ghD', function()
        gs.diffthis '~'
      end, { desc = 'git diff against last commit' })

      -- Toggles
      map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
      map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'toggle git show deleted' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
    end,
  },
}
