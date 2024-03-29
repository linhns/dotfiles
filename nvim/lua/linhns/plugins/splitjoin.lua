local M = {
    "echasnovski/mini.splitjoin",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
}

M.config = function()
    require("mini.splitjoin").setup({})
end

return M
