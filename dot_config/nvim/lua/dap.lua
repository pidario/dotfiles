local home = os.getenv('HOME')
local dap = require('dap')
local vim = require('vim')
--require('dap.ext.vscode').load_launchjs()

dap.set_log_level('TRACE')
dap.adapters.python = {
	type = 'executable';
	command = '/usr/bin/python';
	args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
	{
		type = 'python';
		request = 'launch';
		name = 'Launchpy';
		program = "${file}";
		pythonPath = function()
			return '/usr/bin/python'
		end;
	};
}
dap.adapters.javascript = {
	--type = 'server';
	--host = '127.0.0.1';
	--port = 9229;
	type = 'executable';
	command = '/usr/bin/node';
	args = {home .. '/workspace/vscode-node-debug2/out/src/nodeDebug.js'};
}
dap.configurations.javascript = {
	{
		type = 'javascript';
		request = 'launch';
		name = 'debug';
		program = "${workspaceFolder}/index.js";
	},
}
dap.adapters.go = function(callback)
local handle
local port = 38697
handle, _ =
	vim.loop.spawn(
	"dlv",
	{
		args = {"dap", "-l", "127.0.0.1:" .. port},
		detached = true
	},
	function(code)
		handle:close()
		print("Delve exited with exit code: " .. code)
	end
)
-- Wait 100ms for delve to start
vim.defer_fn(
	function()
		--dap.repl.open()
		callback({type = "server", host = "127.0.0.1", port = port})
	end,
	100)
--callback({type = "server", host = "127.0.0.1", port = port})
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}"
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}"
	},
	-- works with go.mod packages and sub packages
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}"
	}
}
