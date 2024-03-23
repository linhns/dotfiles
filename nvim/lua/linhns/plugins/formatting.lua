local M = {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
    local conform = require("conform")

    conform.setup({
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { "clang-format" },
        },
        format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        },
    })

    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end, { desc = "Format file or range (Visual Mode)" })
end

return M
