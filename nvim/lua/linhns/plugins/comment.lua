local M = {
    "echasnovski/mini.comment",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = {
        "BufNewFile",
        "BufReadPre",
    },
}

M.config = function()
    require("mini.comment").setup({})
end

return M
