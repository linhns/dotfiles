local M = {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
}

local adapters = {}

adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
}

local configurations = {}

configurations.cpp = {
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

M.config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local mason_dap = require("mason-nvim-dap")

    mason_dap.setup({
        ensure_installed = {},
        automatic_installation = true,
    })

    dap.adapters.lldb = adapters.lldb

    dap.configurations.cpp = configurations.cpp

    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    local widgets = require("dap.ui.widgets")

    vim.keymap.set("n", "<localleader>dl", widgets.hover)
    vim.keymap.set("n", "<localleader>dp", widgets.preview)
    vim.keymap.set("n", "<localleader>dc", dap.continue)
    vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<localleader>dB", dap.clear_breakpoints)
    vim.keymap.set("n", "<localleader>dn", dap.step_over)
    vim.keymap.set("n", "<localleader>di", dap.step_into)
    vim.keymap.set("n", "<localleader>do", dap.step_out)
    vim.keymap.set("n", "<localleader>dt", dap.terminate)
    vim.keymap.set("n", "<localleader>dr", dap.run_last)
    vim.keymap.set("n", "<localleader>ds", function()
        widgets.centered_float(widgets.scopes)
    end)
    vim.keymap.set("n", "<localleader>df", function()
        widgets.centered_float(widgets.frames)
    end)

    dapui.setup({
        floating = {
            mappings = {
                close = { "q", "<esc>" },
            },
        },
    })
end

return M
