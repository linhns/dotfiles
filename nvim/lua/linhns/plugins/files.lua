local M = {
    "echasnovski/mini.files",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
}

M.keys = {
    {
        "<leader>ee",
        function()
            require("mini.files").open(vim.uv.cwd())
        end,
        desc = "Open file explorer for current directory",
    },
}

return M
