local lspconfig = require('lspconfig')
local completion = require('completion')
local home = os.getenv('HOME')
local lua_lsp_dir = home .. '/workspace/lua-language-server'

lspconfig.gopls.setup{
	name = "gopls";
	on_attach = completion.on_attach;
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
	on_attach = completion.on_attach;
}

lspconfig.tsserver.setup{
	on_attach = completion.on_attach;
}

lspconfig.pylsp.setup{
	on_attach = completion.on_attach;
}

lspconfig.rls.setup{
	on_attach = completion.on_attach;
}

lspconfig.sumneko_lua.setup{
	cmd = {lua_lsp_dir .. '/bin/Linux/lua-language-server', '-E', lua_lsp_dir .. '/main.lua'};
	on_attach = completion.on_attach;
}

lspconfig.jdtls.setup{
	cmd = { "jdtls.sh" };
	filetypes = { "java" };
	root_dir = require'lspconfig/util'.root_pattern(".git", "pom.xml");
	on_attach = completion.on_attach;
}

lspconfig.dartls.setup{
	on_attach = completion.on_attach;
}
