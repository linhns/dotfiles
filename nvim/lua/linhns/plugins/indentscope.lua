local M = {
    "echasnovski/mini.indentscope",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufEnter",
    opts = {
        draw = {
            animation = function(_, _)
                return 0
            end,
        },
        mappings = {
            object_scope = "",
            object_scope_with_border = "",

            goto_top = "",
            goto_bottom = "",
        },
    },
}

return M
