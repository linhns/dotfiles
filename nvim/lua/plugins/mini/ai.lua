local ai = require("mini.ai")
local extras = require("mini.extra")
local utils = require("utils")

local custom_textobjects = {
    go = {
        s = ai.gen_spec.treesitter({
            a = "@statement.outer",
            i = "@scopename.inner",
        }),
    },
}

ai.setup({
    custom_textobjects = {
        m = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
        }),
        o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@loop.outer", "@conditional.outer" },
            i = { "@block.inner", "@loop.inner", "@conditional.inner" },
        }),
        k = ai.gen_spec.treesitter({
            a = { "@class.outer" },
            i = { "@class.inner" },
        }),
        c = ai.gen_spec.treesitter({
            a = { "@call.outer" },
            i = { "@call.inner" },
        }),
        B = extras.gen_ai_spec.buffer(),
        D = extras.gen_ai_spec.diagnostic(),
        I = extras.gen_ai_spec.indent(),
        L = extras.gen_ai_spec.line(),
        N = extras.gen_ai_spec.number(),
    },
})

vim.api.nvim_create_autocmd("FileType", {
    group = utils.augroup("linhns/ft_textobjects"),
    pattern = vim.fn.join(vim.tbl_keys(custom_textobjects), ","),
    callback = function()
        local ft = vim.bo.filetype
        vim.b.miniai_config = {
            custom_textobjects = custom_textobjects[ft],
        }
    end,
})
