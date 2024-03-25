local M = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
}

M.opts = {
    suggestion = {
        enabled = false
    },
    panel = {
        enabled = false
    }
}

M.config = function(_, opts)
    local copilot = require("copilot")

    copilot.setup(opts)
end

return M
