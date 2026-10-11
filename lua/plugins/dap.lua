local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.adapters.python = {
	type = "executable",
	command = "debugpy-adapter",
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch current file",
		program = "${file}",
		console = "integratedTerminal",
	},
}

dap.adapters.bashdb = {
	type = "executable",
	command = "bash-debug-adapter",
	name = "bashdb",
}

dap.configurations.sh = {
	{
		type = "bashdb",
		request = "launch",
		name = "Launch current script",
		program = "${file}",
		cwd = "${workspaceFolder}",
		pathBash = "bash",
	},
}

dap.adapters.codelldb = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}

local native_configurations = {
	{
		name = "Launch executable",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

for _, filetype in ipairs({ "c", "cpp", "rust", "zig" }) do
	dap.configurations[filetype] = vim.deepcopy(native_configurations)
end

dap.adapters.go = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "go",
		name = "Debug current package",
		request = "launch",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}

dap.adapters.coreclr = {
	type = "executable",
	command = "netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Launch .NET application",
		request = "launch",
		program = function()
			return vim.fn.input("Path to compiled DLL: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

local js_debug_adapter = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = { "${port}" },
	},
}

dap.adapters["pwa-node"] = vim.deepcopy(js_debug_adapter)
dap.adapters["pwa-chrome"] = vim.deepcopy(js_debug_adapter)
dap.adapters["pwa-msedge"] = vim.deepcopy(js_debug_adapter)
dap.adapters.firefox = {
	type = "executable",
	command = "firefox-debug-adapter",
}

local browser_configurations = {
	{
		type = "pwa-chrome",
		request = "launch",
		name = "Launch Chrome",
		url = function()
			return vim.fn.input("URL: ", "http://localhost:3000/")
		end,
		webRoot = "${workspaceFolder}",
	},
	{
		type = "pwa-chrome",
		request = "attach",
		name = "Attach to Chrome on :9222",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
	{
		type = "pwa-msedge",
		request = "attach",
		name = "Attach to Edge on :9222",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
	{
		type = "firefox",
		request = "launch",
		name = "Launch Firefox",
		url = function()
			return vim.fn.input("URL: ", "http://localhost:3000/")
		end,
		webRoot = "${workspaceFolder}",
		reAttach = true,
	},
	{
		type = "firefox",
		request = "attach",
		name = "Attach to Firefox",
		url = function()
			return vim.fn.input("URL: ", "http://localhost:3000/")
		end,
		webRoot = "${workspaceFolder}",
	},
}

local js_configurations = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch current file (Node)",
		program = "${file}",
		cwd = "${workspaceFolder}",
		sourceMaps = true,
	},
}
vim.list_extend(js_configurations, vim.deepcopy(browser_configurations))

for _, filetype in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
	dap.configurations[filetype] = vim.deepcopy(js_configurations)
end
dap.configurations.svelte = vim.deepcopy(browser_configurations)

dap.adapters.nlua = function(callback, config)
	callback({
		type = "server",
		host = config.host or "127.0.0.1",
		port = config.port or 8086,
	})
end

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to Neovim (OSV)",
		host = "127.0.0.1",
		port = 8086,
	},
}

vim.api.nvim_create_user_command("LuaDebugStart", function()
	require("osv").launch({ port = 8086 })
end, { desc = "Start the Neovim Lua debug adapter" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Conditional breakpoint" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
