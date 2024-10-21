require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        sh = { "shfmt" },
        go = { "goimports", lsp_format = "first" },
        sql = { "sqlfluff" },
        yaml = { "yamlfmt" },
    },
    format_on_save = {
        timeout_ms = 1000,
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    -- Customize formatters
    formatters = {
        shfmt = {
            prepend_args = { "-i", "2" },
        },
        sqlfluff = {
            args = { "format", "--dialect=ansi", "-" },
            cwd = require("conform.util").root_file({ ".sqlfluff" }),
            require_cwd = false,
        },
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
    require("conform").format({ async = true })
end, { desc = "Format (buffer)" })
