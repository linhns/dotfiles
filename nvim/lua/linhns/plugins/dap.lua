local M = {
    "mfussenegger/nvim-dap",
    ft = { "cpp", "go" },
    dependencies = {
        {
            "leoluz/nvim-dap-go",
            opts = {},
        },
    },
}

M.config = function()
    local adapters = require("linhns.plugins.dap.adapters")
    local configurations = require("linhns.plugins.dap.configurations")

    local dap = require("dap")

    adapters.setup(dap)
    configurations.setup(dap)

    local widgets = require("dap.ui.widgets")

    vim.keymap.set("n", "<localleader>dl", widgets.hover, { desc = "Evaluate Expression Under Cursor" })
    vim.keymap.set("n", "<localleader>dp", widgets.preview, { desc = "Preview" })
    vim.keymap.set("n", "<localleader>dc", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<localleader>dS", dap.continue, { desc = "Start" })
    vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<localleader>dB", dap.clear_breakpoints, { desc = "Clear All Breakpoints" })
    vim.keymap.set("n", "<localleader>dn", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<localleader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<localleader>do", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<localleader>dt", dap.terminate, { desc = "Stop Debugging" })
    vim.keymap.set("n", "<localleader>dr", dap.run_last, { desc = "Rerun Last Debug Config" })
    vim.keymap.set("n", "<localleader>ds", function()
        widgets.centered_float(widgets.scopes)
    end)
    vim.keymap.set("n", "<localleader>df", function()
        widgets.centered_float(widgets.frames)
    end)
end

return M
