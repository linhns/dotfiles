return {
    "echasnovski/mini.diff",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>go",
            function()
                require("mini.diff").toggle_overlay(0)
            end,
            desc = "Toggle mini.diff overlay",
        },
    },
}
