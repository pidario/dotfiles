require'nvim-treesitter.configs'.setup {
	--one of "all", "language", or a list of languages
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		-- false will disable the whole extension
		enable = true,
	},
}
