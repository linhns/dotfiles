require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "lua",
        "c",
        "cpp",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "html",
        "javascript",
        "typescript",
        "css",
    },
    highlight = {
        enable = true,
        disable = function(_, buf)
            if not vim.bo[buf].modifiable then
                return false
            end
            local ok, stats =
                pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
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
})

vim.treesitter.language.register("html", "gohtml")

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "go",
        "lua",
        "cpp",
        "html",
        "javascript",
        "typescript",
        "gohtml",
    },
    group = vim.api.nvim_create_augroup("linhns/treesitter", { clear = true }),
    desc = "Set up treesitter",
    callback = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})
