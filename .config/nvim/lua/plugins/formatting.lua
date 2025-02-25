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
    format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return {
            timeout_ms = 5000,
        }
    end,
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

vim.api.nvim_create_user_command("FormatToggle", function(args)
    if args.bang then
        -- FormatToggle! will toggle formatting just for this buffer
        vim.b.disable_autoformat = not vim.b.disable_autoformat
    else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
    end
end, {
    desc = "Toggle autoformat",
    bang = true,
})
