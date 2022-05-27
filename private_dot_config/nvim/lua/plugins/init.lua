-- automatically install packer, if not already installed
local fn = vim.fn
local status_notify_ok, notify = pcall(require, "notify")
vim.notify = notify

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
        autocmd BufWritePost init.lua source <afile> | PackerInstall
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    local message = "packer unavailable!"
    if status_notify_ok then
        vim.notify(message)
        return
    end
    print(message)
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

    use 'rcarriga/nvim-notify' -- notifications

    use 'nvim-lualine/lualine.nvim' -- status bar

    use 'romgrk/barbar.nvim' -- tab bar

    use "numToStr/Comment.nvim" -- Easily comment stuff

    use "norcalli/nvim-colorizer.lua" -- color highlighter #000000 #FFFFFF

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    -- treesitter plugins
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- telescope plugins
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }

    -- LSP Plugins
    use 'williamboman/nvim-lsp-installer' -- automatically install configured lsp server
    use 'neovim/nvim-lspconfig'

    -- Autocompletion plugins
    use 'onsails/lspkind-nvim' -- icons in completion menu
    use 'hrsh7th/nvim-cmp' --auto-completion plugin
    use 'hrsh7th/cmp-buffer' --buffer completion plugin
    use 'hrsh7th/cmp-path' --path completion plugin
    use 'hrsh7th/cmp-cmdline' --cmdline completion plugin
    use 'hrsh7th/cmp-nvim-lsp' --lsp source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' --snippets source for nvim-cmp

    -- Snippets
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Prettier
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'MunifTanjim/prettier.nvim'

    use 'github/copilot.vim'
    -- ^^^^^^^ Add plugins here ^^^^^^^

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

require('plugins.nvim-tree-config')
require('plugins.nvim-notify-config')
require('plugins.lualine-config')
require('plugins.barbar-config')
require('plugins.nvim-colorizer-config')
require('plugins.treesitter-config')
require('plugins.telescope-config')
require('plugins.markdown-preview-config')
require('plugins.lsp')

return result
