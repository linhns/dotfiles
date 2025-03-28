local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        { mode = "n", keys = "<leader>b", desc = "+Buffers" },
        { mode = "n", keys = "<leader>c", desc = "+Code" },
        { mode = "n", keys = "<leader>cc", desc = "+Chat" },
        { mode = "n", keys = "<leader>d", desc = "+Debug" },
        { mode = "n", keys = "<leader>e", desc = "+File Explorer" },
        { mode = "n", keys = "<leader>f", desc = "+Find" },
        { mode = "n", keys = "<leader>g", desc = "+Git/Diff" },
        { mode = "n", keys = "<leader>l", desc = "+LSP" },
        { mode = "n", keys = "<leader>gf", desc = "+Git: Find" },
        { mode = "n", keys = "<leader>s", desc = "+Session" },
        { mode = "n", keys = "<leader>t", desc = "+Test" },
        { mode = "v", keys = "<leader>v", desc = "+Visit" },

        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },

    window = {
        delay = 300,
        config = {
            width = "auto",
            border = "single",
        },
    },
})

miniclue.set_mapping_desc("n", "grn", "Rename Symbol")
miniclue.set_mapping_desc("n", "gra", "Show Code Actions")
