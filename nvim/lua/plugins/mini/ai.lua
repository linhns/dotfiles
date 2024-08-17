local ai = require("mini.ai")
local extras = require("mini.extra")
ai.setup({
    custom_textobjects = {
        F = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
        }),
        o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@loop.outer", "@conditional.outer" },
            i = { "@block.inner", "@loop.inner", "@conditional.inner" },
        }),
        c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
        }),
        B = extras.gen_ai_spec.buffer(),
        D = extras.gen_ai_spec.diagnostic(),
        I = extras.gen_ai_spec.indent(),
        L = extras.gen_ai_spec.line(),
        N = extras.gen_ai_spec.number(),
    },
})
