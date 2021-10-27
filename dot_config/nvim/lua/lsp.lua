local lspconfig = require('lspconfig')
local home = os.getenv('HOME')
local lua_lsp_dir = home .. '/workspace/lua-language-server'

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.gopls.setup{
	name = "gopls";
	capabilities = capabilities;
	cmd = {"gopls"};
	filetypes = {'go','gomod'};
	root_patterns = {'go.mod','.git'};
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#settings
	init_options = {
		usePlaceholders=true;
		linkTarget="pkg.go.dev";
		completionDocumentation=true;
		completeUnimported=true;
		deepCompletion=true;
		fuzzyMatching=true;
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
	cmd = {lua_lsp_dir .. '/bin/Linux/lua-language-server', '-E', lua_lsp_dir .. '/main.lua'};
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
