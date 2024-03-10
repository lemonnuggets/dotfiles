--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- [[ Setting options ]]
require 'core.options'

-- [[ Basic Keymaps ]]
require 'core.keymaps'

-- [[ Configure plugins ]]
require 'lazy-init'

-- [[ Debug Nvim Events ]]
-- require 'events-debug'

-- vim: ts=2 sts=2 sw=2 et
