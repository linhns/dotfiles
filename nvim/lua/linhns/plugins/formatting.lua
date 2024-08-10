local M = {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true })
            end,
            mode = { "n", "v" },
            desc = "Format file or range (Visual Mode)",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            sh = { "shfmt" },
            go = { "gofumpt" },
        },
        format_on_save = {
            timeout_ms = 500,
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

return M
