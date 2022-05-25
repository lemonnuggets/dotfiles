-- automatically install packer, if not already installed
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- automatically run PackerCompile whenever plugins/init.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end


-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

local result = packer.startup(function(use)
    -- vvvvvvv Add plugins here vvvvvvv
    use 'wbthomason/packer.nvim' -- packer manages itself

    use { 'dracula/vim', as = 'dracula' }

    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'
    -- ^^^^^^^ Add plugins here ^^^^^^^

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

require('plugins.nvim-tree-config')
require('plugins.lsp')

return result
