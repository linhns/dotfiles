require("mason-tool-installer").setup({
    ensure_installed = {
        -- LSP Servers
        "gopls",
        "cmake-language-server",
        "lua-language-server",
        "bash-language-server",
        "typescript-language-server",
        "dockerfile-language-server",
        "some-sass-language-server",
        "yaml-language-server",
        "protols",
        "basedpyright",

        -- Debuggers
        "delve",

        -- Linters
        "golangci-lint",
        "ruff",
        "cmakelint",
        "markdownlint",
        "shellcheck",
        "cpplint",
        "sqlfluff",

        -- Formatters
        "goimports",
        "stylua",
        "yamlfmt",
        "shfmt",

        -- Tools
        "impl",
        "gomodifytags",
        "gotests",
    },
    run_on_start = true,
})
