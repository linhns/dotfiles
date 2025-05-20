local check_go_exists = function()
    return not os.execute("go version")
end

local check_cmake_exists = function()
    return not os.execute("cmake --version")
end

local check_python_exists = function()
    return not os.execute("python3 --version")
end

require("mason-tool-installer").setup({
    ensure_installed = {
        { "gopls", condition = check_go_exists },
        { "delve", condition = check_go_exists },
        { "golangci-lint", condition = check_go_exists },
        { "gomodifytags", condition = check_go_exists },
        { "goimports", condition = check_go_exists },
        { "impl", condition = check_go_exists },
        { "gotests", condition = check_go_exists },
        { "cmake-language-server", condition = check_cmake_exists },
        { "cmakelint", condition = check_cmake_exists },
        { "python-lsp-server", condition = check_python_exists },
        { "ruff", condition = check_python_exists },
        "markdownlint",
        "stylua",
        "lua-language-server",
        "yamlfmt",
        "cpplint",
        "shfmt",
        "shellcheck",
        "bash-language-server",
    },
})
