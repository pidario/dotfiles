local lspconfig = require('lspconfig')
local coq = require('coq')
local data = os.getenv('XDG_DATA_HOME')

vim.g.coq_settings = { auto_start = 'shut-up' }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

lspconfig.gopls.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
}))

lspconfig.clangd.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
}))

lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
}))

lspconfig.pylsp.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
}))

lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
	cmd = { "rustup", "run", "stable", "rust-analyzer" };
	on_attach = on_attach;
}))

lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
}))

lspconfig.dartls.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
}))

lspconfig.svelte.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
}))

local npm_path = data .. "/npm/lib/node_modules"
local cmd = { "ngserver", "--stdio", "--tsProbeLocations", npm_path, "--ngProbeLocations", npm_path }
lspconfig.angularls.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach;
	cmd = cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
}))
