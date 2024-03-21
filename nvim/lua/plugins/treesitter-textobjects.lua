local M = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
}

local keymaps = {
    ['am'] = { query = '@function.outer', desc = 'Select outer part of a function definition' },
    ['im'] = { query = '@function.inner', desc = 'Select inner part of a function definition' },

    ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
    ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },

    ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
    ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },

    ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
    ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

    ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
    ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },

    ['ab'] = { query = '@block.outer', desc = 'Select outer part of a block' },
    ['ib'] = { query = '@block.inner', desc = 'Select inner part of a block' },

    ['ar'] = { query = '@return.outer', desc = 'Select outer part of a return' },
    ['ir'] = { query = '@return.inner', desc = 'Select inner part of a return' },

    ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter' },
    ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter' },

    ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
    ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
    ['l='] = { query = '@assignment.lhs', desc = 'Select lhs part of an assignment' },
    ['r='] = { query = '@assignment.rhs', desc = 'Select rhs part of an assignment' },
}

local swap_next = {
    ['<leader>na'] = '@parameter.inner',
    ['<leader>nm'] = '@function.outer',
}

local swap_previous = {
    ['<leader>pa'] = '@parameter.inner',
    ['<leader>pm'] = '@function.outer',
}

local goto_next_start = {
    [']f'] = '@call.outer',
    [']m'] = '@function.outer',
    [']c'] = '@class.outer',
    [']i'] = '@conditional.outer',
    [']l'] = '@loop.outer',

    [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
    [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
}

local goto_next_end = {
    [']F'] = '@call.outer',
    [']M'] = '@function.outer',
    [']C'] = '@class.outer',
    [']I'] = '@conditional.outer',
    [']L'] = '@loop.outer',
}

local goto_previous_end = {
    ['[f'] = '@call.outer',
    ['[m'] = '@function.outer',
    ['[c'] = '@class.outer',
    ['[i'] = '@conditional.outer',
    ['[l'] = '@loop.outer',
}

local goto_previous_end = {
    ['[F'] = '@call.outer',
    ['[M'] = '@function.outer',
    ['[C'] = '@class.outer',
    ['[I'] = '@conditional.outer',
    ['[L'] = '@loop.outer',
}

M.config = function()
    local configs = require('nvim-treesitter.configs')
    configs.setup({
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = keymaps,
            },
            swap = {
                enable = true,
                swap_next = swap_next,
                swap_previous = swap_previous,
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = goto_next_start,
                goto_next_end = goto_next_end,
                goto_previous_start = goto_previous_start,
                goto_previous_end = goto_previous_end,
            }
        }
    })

    local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

    vim.keymap.set({ 'n', 'x', 'o'}, ';', ts_repeat_move.repeat_last_move)

    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
end

return M
