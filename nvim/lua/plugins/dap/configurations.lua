local M = {}

M.setup = function(dap)
	dap.configurations.cpp = {
		{
			name = "Launch LLDB",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
		},
	}
end

return M
