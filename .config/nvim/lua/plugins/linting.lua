local lint = require("lint")

lint.linters_by_ft = {
    cpp = { "cpplint" },
    cmake = { "cmakelint" },
    markdown = { "markdownlint" },
    go = { "golangcilint" },
    python = { "mypy" },
    sql = { "sqlfluff" },
    javascript = { "biomejs" },
    typescript = { "biomejs" },
    javascriptreact = { "biomejs" },
    typescriptreact = { "biomejs" },
}

local linters = require("lint").linters
linters["sqlfluff"].stdin = true

local venv_env_vars = { "VIRTUAL_ENV", "CONDA_PREFIX" }
local venv = vim.iter(venv_env_vars):find(function(s)
    return s ~= ""
end)

if venv then
    linters["mypy"].cmd = "python3"
    linters["mypy"].args = vim.list_extend({ "-m", "mypy" }, linters["mypy"].args)
end

linters["mypy"].args = vim.list_extend(linters["mypy"].args, {
    "--python-executable",
    vim.fn.exepath("python3"),
})

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
