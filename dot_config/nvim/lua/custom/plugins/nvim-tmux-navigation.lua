return {
  'alexghergh/nvim-tmux-navigation',
  config = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    nvim_tmux_nav.setup {
      disable_when_zoomed = true, -- defaults to false
    }

    vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = 'Navigate to left pane' })
    vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown, { desc = 'Navigate to bottom pane' })
    vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp, { desc = 'Navigate to top pane' })
    vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight, { desc = 'Navigate to right pane' })
    vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive, { desc = 'Navigate to last active pane' })
    vim.keymap.set('n', '<C-/>', nvim_tmux_nav.NvimTmuxNavigateNext, { desc = 'Navigate to next pane' })
  end,
}
