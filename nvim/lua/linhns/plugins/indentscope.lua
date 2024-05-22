local M = {
    "echasnovski/mini.indentscope",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufEnter",
}

M.config = function()
    local indentscope = require("mini.indentscope")
    -- vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#ff0000" })
    indentscope.setup({
        draw = {
            animation = indentscope.gen_animation.none(),
        },
        mappings = {
            object_scope = "",
            object_scope_with_border = "",

            goto_top = "",
            goto_bottom = "",
        },
    })
end

return M
