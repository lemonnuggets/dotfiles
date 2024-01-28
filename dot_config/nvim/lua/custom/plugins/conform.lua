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
			desc = 'Format buffer',
		},
	},
	opts = {
		formatters_by_ft = formatters,
		format_on_save = function(bufnr)
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
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
