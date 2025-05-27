return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require "configs.conform",
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "configs.lspconfig"
		end,
	},
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "/" },
			-- log_level = 'debug',
		},
	},
	{
		"vim-test/vim-test",
		cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
		keys = { "<localleader>tf", "<localleader>tn", "<localleader>ts" },
		config = function()
			vim.cmd [[
				function! ToggleTermStrategy(cmd) abort
					call luaeval("require('toggleterm').exec(_A[1])", [a:cmd])
				endfunction
				let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
			]]
			vim.g["test#strategy"] = "toggleterm"
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
}
