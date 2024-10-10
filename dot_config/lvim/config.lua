-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- install:
-- LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

-- update
-- :LvimUpdate

-- update plugins
-- :LvimSyncCorePlugins

-- cache reset
-- :LvimCacheReset

-- :LspInstall angularls
require("lvim.lsp.manager").setup("angularls")

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{
		name = "prettier",
		---@usage arguments to pass to the formatter
		args = { "--print-width", "80" },
		---@usage only start in these filetypes, by default it will attach to all filetypes it supports
		filetypes = { "typescript", "javascript" },
	},
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
	{ name = "eslint_d" },
}

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.expandtab = false
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.listchars = {
	eol        = '↵',
	nbsp       = '␣',
	tab        = '⟩•',
	lead       = '^',
	trail      = '␣',
	extends    = '⟩',
	precedes   = '⟨',
	multispace = '_'
}
vim.opt.list = true
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

lvim.format_on_save.enabled = true
lvim.builtin.terminal.active = true
lvim.colorscheme = "darkplus"
lvim.builtin.bufferline.options.sort_by = "insert_at_end"
lvim.builtin.bufferline.options.numbers = "ordinal"

lvim.plugins = {
	{
		"lunarvim/darkplus.nvim",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("indent_blankline").setup({
				filetype_exclude = { "help", "terminal", "dashboard", "lspinfo" },
				buftype_exclude = { "terminal", "dashboard", "nofile", "quickfix" },
				show_trailing_blankline_indent = true,
				show_first_indent_level = true,
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_root_dir = vim.fn.stdpath("cache") .. "/sessions/",
				auto_session_enabled = true,
				auto_save_enabled = true,
				auto_restore_enabled = true,
				auto_session_suppress_dirs = nil,
				auto_session_use_git_branch = true,
			})
		end,
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
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
		config = function()
			require('sonarlint').setup({
				server = {
					cmd = {
						vim.fn.stdpath('data') .. "/mason/" .. 'bin/sonarlint-language-server',
						'-stdio',
						'-analyzers',
						vim.fn.expand(vim.fn.stdpath('data') .. "/mason/" .. "share/sonarlint-analyzers/sonarjs.jar"),
						vim.fn.expand(vim.fn.stdpath('data') .. "/mason/" .. "share/sonarlint-analyzers/sonarhtml.jar"),
						vim.fn.expand(vim.fn.stdpath('data') .. "/mason/" .. "share/sonarlint-analyzers/sonarjava.jar"),
						vim.fn.expand(vim.fn.stdpath('data') ..
						"/mason/" .. "share/sonarlint-analyzers/sonarjavasymbolicexecution.jar"),
					}
				},
				filetypes = {
					'typescript',
					'javascript',
					'html',
					'java'
				}
			})
		end
	}
}

lvim.keys.normal_mode["<C-PageDown>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-PageUp>"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.which_key.mappings["bp"] = {
	"<cmd>BufferLineTogglePin<CR>", "Pin"
}

lvim.builtin.which_key.mappings["F"] = {
	name = "Find/Replace",
	f = { "<cmd>lua require('spectre').toggle()<cr>", "Find Toggle" },
	p = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Find in Project" },
	c = { "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>", "Find in Current File" },
}

lvim.builtin.which_key.mappings["T"] = {
	name = "Test",
	f = { "<cmd>TestFile<cr>", "File" },
	n = { "<cmd>TestNearest<cr>", "Nearest" },
	l = { "<cmd>TestLast<cr>", "Last" },
	s = { "<cmd>TestSuite<cr>", "Suite" },
}

local telescope_custom_actions = {}
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

function telescope_custom_actions._select_one_or_multi(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		actions.close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format('%s %s', 'edit', j.path))
			end
		end
	else
		actions.select_default(prompt_bufnr)
	end
end

lvim.builtin.telescope.defaults.mappings = {
	i = {
		["TAB"] = actions.toggle_selection,
		["<CR>"] = telescope_custom_actions._select_one_or_multi,
	},
}
