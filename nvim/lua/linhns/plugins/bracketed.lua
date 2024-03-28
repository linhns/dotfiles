local M = {
    "echasnovski/mini.bracketed",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
}

M.config = function()
    require("mini.bracketed").setup({
        {
            -- First-level elements are tables describing behavior of a target:
            --
            -- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
            --   For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
            --   Supply empty string `''` to not create mappings.
            --
            -- - <options> - table overriding target options.
            --
            -- See `:h MiniBracketed.config` for more info.

            buffer = { suffix = "b", options = {} },
            comment = { suffix = "", options = {} },
            conflict = { suffix = "x", options = {} },
            diagnostic = { suffix = "d", options = {} },
            file = { suffix = "", options = {} },
            indent = { suffix = "", options = {} },
            jump = { suffix = "j", options = {} },
            location = { suffix = "l", options = {} },
            oldfile = { suffix = "o", options = {} },
            quickfix = { suffix = "q", options = {} },
            treesitter = { suffix = "t", options = {} },
            undo = { suffix = "u", options = {} },
            window = { suffix = "w", options = {} },
            yank = { suffix = "", options = {} },
        },
    })
end

return M
