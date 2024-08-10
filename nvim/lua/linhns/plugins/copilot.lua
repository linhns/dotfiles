local M = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = {
            auto_trigger = true,
        },
        panel = {
            enabled = false,
        },
    },
}

return M
