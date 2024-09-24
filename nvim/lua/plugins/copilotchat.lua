require("CopilotChat").setup({
    -- window = {
    --     layout = "float",
    --     width = 0.6,
    --     height = 0.6,
    -- },
})

local utils = require("utils")
local cmd = utils.cmd
local keymapper = utils.map
local nxmap = function(...)
    utils.nxmap(keymapper, ...)
end

nxmap("<leader>cct", cmd("CopilotChatToggle"), "Toggle a Chat Buffer")
