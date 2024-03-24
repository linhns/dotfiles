local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {
        "BufNewFile",
        "BufReadPre",
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}

M.config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "haskell" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    })
end

return M
