local M = {}

M.setup = function(dap)
    dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
        name = "lldb",
    }
end

return M
