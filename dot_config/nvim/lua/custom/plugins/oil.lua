return {
  'stevearc/oil.nvim',
  opts = {
    columns = {
      'icons',
    },
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, bufnr)
        return vim.startswith(name, 'node_modules') or vim.startswith(name, '.DS_Store')
      end,
    },
  },
  init = function()
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
