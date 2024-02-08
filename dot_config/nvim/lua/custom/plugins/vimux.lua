-- reference: https://www.bugsnag.com/blog/tmux-and-vim/
return {
  'preservim/vimux',
  config = function()
    vim.keymap.set('n', '<leader>vp', ':VimuxPromptCommand<CR>', { desc = 'Prompt for a command to run' })
    vim.keymap.set('n', '<leader>vl', ':VimuxRunLastCommand<CR>', { desc = 'Run last command executed by VimuxRunCommand' })
    -- vim.keymap.set('n', '<leader>vi', ':VimuxInspectRunner<CR>', { desc = 'Inspect runner pane' })
    -- vim.keymap.set('n', '<leader>vz', ':VimuxZoomRunner<CR>', { desc = 'Zoom the tmux runner pane' })
  end,
}
