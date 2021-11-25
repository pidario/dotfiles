local lspconfig = require('lspconfig')
local data = os.getenv('XDG_DATA_HOME')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.gopls.setup{
	name = "gopls";
	capabilities = capabilities;
	cmd = { "gopls" };
	filetypes = { "go", "gomod" };
	root_patterns = { "go.mod", ".git" };
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#settings
	init_options = {
		usePlaceholders = true;
		linkTarget = "pkg.go.dev";
		completionDocumentation = true;
		completeUnimported = true;
		deepCompletion = true;
		fuzzyMatching = true;
	};
}

lspconfig.clangd.setup{
	capabilities = capabilities;
}

lspconfig.tsserver.setup{
	capabilities = capabilities;
}

lspconfig.pylsp.setup{
	capabilities = capabilities;
}

lspconfig.rls.setup{
	capabilities = capabilities
}

lspconfig.sumneko_lua.setup{
	cmd = { "lua-language-server" };
	capabilities = capabilities;
}

lspconfig.jdtls.setup{
	cmd = { "jdtls.sh" };
	filetypes = { "java" };
	root_dir = require'lspconfig/util'.root_pattern(".git", "pom.xml");
	capabilities = capabilities;
}

lspconfig.dartls.setup{
	capabilities = capabilities;
}

lspconfig.svelte.setup{
	capabilities = capabilities;
}

local npm_path = data .. "/npm/lib/node_modules"
local cmd = { "ngserver", "--stdio", "--tsProbeLocations", npm_path, "--ngProbeLocations", npm_path }
lspconfig.angularls.setup{
	capabilities = capabilities,
	cmd = cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
}
