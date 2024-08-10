return {
    "echasnovski/mini-git",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    main = "mini.git",
    opts = {},
    keys = {
        {
            "<leader>gd",
            function()
                require("mini.git").show_at_cursor()
            end,
            desc = "Show git info at cursor",
            mode = { "n", "x" },
        },
    },
}
