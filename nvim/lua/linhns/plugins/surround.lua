local M = {
    "echasnovski/mini.surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
}

M.config = function()
    require("mini.surround").setup({
        -- Configuration here, or leave empty to use defaults
    })
end

return M
