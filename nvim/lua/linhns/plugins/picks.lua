return {
    "echasnovski/mini.pick",
    version = "*",
    event = { "VeryLazy" },
    cmd = "Pick",
    opts = {},
    keys = {
        {
            "<leader>ff",
            function()
                require("mini.pick").builtin.files()
            end,
            desc = "Find files",
        },
    },
}
