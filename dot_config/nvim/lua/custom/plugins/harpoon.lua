return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>hh', function()
      harpoon:list():append()
    end, { desc = '[H]arpoon Append' })

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():select(1)
    end, { desc = '[H]arpoon 1' })

    vim.keymap.set('n', '<leader>hs', function()
      harpoon:list():select(2)
    end, { desc = '[H]arpoon 2' })

    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():select(3)
    end, { desc = '[H]arpoon 3' })

    vim.keymap.set('n', '<leader>hf', function()
      harpoon:list():select(4)
    end, { desc = '[H]arpoon 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = '[H]arpoon [P]rev' })
    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = '[H]arpoon [N]ext' })

    vim.keymap.set('n', '<leader>hw', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon Window' })
  end,
}
