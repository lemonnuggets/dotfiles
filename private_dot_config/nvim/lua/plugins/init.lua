local packer = require("plugins.packer-config")

local result = packer.startup(function(use)
	-- vvvvvvv Add plugins here vvvvvvv
	use("wbthomason/packer.nvim") -- packer manages itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	use({ "dracula/vim", as = "dracula" })

	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	use("rcarriga/nvim-notify") -- notifications

	use("nvim-lualine/lualine.nvim") -- status bar

	use("romgrk/barbar.nvim") -- tab bar

	use("numToStr/Comment.nvim") -- Easily comment stuff

	use("norcalli/nvim-colorizer.lua") -- color highlighter #000000 #FFFFFF

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	use("folke/which-key.nvim")

	-- treesitter plugins
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- telescope plugins
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })
	use("nvim-telescope/telescope-media-files.nvim")

	-- LSP Plugins
	use("williamboman/nvim-lsp-installer") -- automatically install configured lsp server
	use("neovim/nvim-lspconfig")

	-- Autocompletion plugins
	use("onsails/lspkind-nvim") -- icons in completion menu
	use("hrsh7th/nvim-cmp") --auto-completion plugin
	use("hrsh7th/cmp-buffer") --buffer completion plugin
	use("hrsh7th/cmp-path") --path completion plugin
	use("hrsh7th/cmp-cmdline") --cmdline completion plugin
	use("hrsh7th/cmp-nvim-lsp") --lsp source for nvim-cmp
	use("hrsh7th/cmp-nvim-lua") --lsp source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") --snippets source for nvim-cmp

	-- Snippets
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- Prettier
	use("jose-elias-alvarez/null-ls.nvim")
	use("MunifTanjim/prettier.nvim")

	use("github/copilot.vim")

	use({ "akinsho/toggleterm.nvim", tag = "v1.*" })
	-- ^^^^^^^ Add plugins here ^^^^^^^

	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

require("plugins.nvim-tree-config")
require("plugins.nvim-notify-config")
require("plugins.lualine-config")
require("plugins.barbar-config")
require("plugins.comment-nvim-config")
require("plugins.nvim-colorizer-config")
require("plugins.which-key-config")
require("plugins.treesitter-config")
require("plugins.telescope-config")
require("plugins.markdown-preview-config")
require("plugins.gitsigns-config")
require("plugins.autopairs")
require("plugins.toggleterm-config")
require("plugins.cmp")
require("plugins.lsp")

return result
