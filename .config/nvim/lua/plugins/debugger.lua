local adapters = require("plugins.dap.adapters")
local configurations = require("plugins.dap.configurations")

local dap = require("dap")

adapters.setup(dap)
configurations.setup(dap)

require("dap-go").setup({})

if vim.fn.executable("uv") == 1 then
    require("dap-python").setup("uv")
else
    require("dap-python").setup()
end
