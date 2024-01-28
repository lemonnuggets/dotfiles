return {
	'HiPhish/rainbow-delimiters.nvim',
	ft = { "clojure" },
	init = function()
		-- This module contains a number of default definitions
		local rainbow_delimiters = require 'rainbow-delimiters'

		---@type rainbow_delimiters.config
		vim.g.rainbow_delimiters = {
			strategy = {
				[''] = rainbow_delimiters.strategy['global'],
				vim = rainbow_delimiters.strategy['local'],
			},
			query = {
				[''] = 'rainbow-delimiters',
				lua = 'rainbow-blocks',
			},
			priority = {
				[''] = 110,
				lua = 210,
			},
			highlight = {
				'RainbowDelimiterRed',
				'RainbowDelimiterYellow',
				'RainbowDelimiterGreen',
				'RainbowDelimiterBlue',
				'RainbowDelimiterViolet',
				-- 'RainbowDelimiterCyan',
				-- 'RainbowDelimiterOrange',
			},
		}
	end,
	-- 'luochen1990/rainbow',
	-- opt = true,
	-- init = function()
	-- 	-- print("hello rainbow")
	-- 	vim.g.rainbow_active = 1
	-- end
}
