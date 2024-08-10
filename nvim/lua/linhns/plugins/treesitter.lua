local M = {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = {
        "BufNewFile",
        "BufReadPost",
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "cpp",
            "haskell",
            "go",
            "gomod",
            "gowork",
            "gosum",
        },
        sync_install = false,
        auto_install = false,
        highlight = {
            enable = true,
            disable = function(_, buf)
                if not vim.bo[buf].modifiable then
                    return false
                end
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                return ok and stats and stats.size > 100 * 1024
            end,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        additional_vim_regex_highlighting = false,
    },
}

M.config = function(_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
end

return M
