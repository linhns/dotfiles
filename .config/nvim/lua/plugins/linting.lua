local lint = require("lint")

lint.linters_by_ft = {
    cpp = { "cpplint" },
    cmake = { "cmakelint" },
    markdown = { "markdownlint" },
    go = { "golangcilint" },
    sql = { "sqlfluff" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    ghaction = { "actionlint" },
}

local linters = require("lint").linters
linters["sqlfluff"].stdin = true

-- Autocommand configuration
local lint_augroup = vim.api.nvim_create_augroup("linhns/lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})

-- Keymap configuration
local utils = require("utils")
local keymapper = utils.map
local nmap = function(...)
    utils.nmap(keymapper, ...)
end

nmap("<leader>cl", lint.try_lint, "Lint (buffer)")
