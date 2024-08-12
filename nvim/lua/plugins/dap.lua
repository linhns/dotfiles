local adapters = require("plugins.dap.adapters")
local configurations = require("plugins.dap.configurations")

local dap = require("dap")

adapters.setup(dap)
configurations.setup(dap)

require("dap-go").setup({})
