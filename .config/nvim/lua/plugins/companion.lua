require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "copilot",
        },
        inline = {
            adapter = "copilot",
        },
        agent = {
            adapter = "copilot",
        },
    },
})

local utils = require("utils")
local cmd = utils.cmd
local keymapper = utils.map
local nmap = function(...)
    utils.nmap(keymapper, ...)
end
local nxmap = function(...)
    utils.nxmap(keymapper, ...)
end

nxmap("<leader>cca", cmd("CodeCompanionActions"), "Open the Action Palette")
nxmap("<leader>cct", cmd("CodeCompanionToggle"), "Toggle a Chat Buffer")
