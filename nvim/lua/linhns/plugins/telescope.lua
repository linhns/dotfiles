local M = {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        {
            "nvim-telescope/telescope-dap.nvim",
        },
    },
}

function M.config()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                },
            },
        },

        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    })

    -- Keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

    telescope.load_extension("fzf")
    telescope.load_extension("dap")
    telescope.load_extension("persisted")
end

return M
