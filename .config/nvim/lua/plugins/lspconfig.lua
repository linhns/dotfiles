local lspconfig = require("lspconfig")
local utils = require("utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("gopls", {
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtml" },
    settings = {
        gopls = {
            codelenses = {
                test = true,
            },
            analyses = {
                unusedvariable = true,
            },
            gofumpt = true,
            usePlaceholders = true,
            templateExtensions = { "gotmpl", "gohtml", "tmpl" },
            semanticTokens = true,
        },
    },
})
vim.lsp.enable("gopls")

vim.lsp.config("clangd", {
    capabilities = vim.tbl_deep_extend("error", capabilities, {
        offsetEncoding = { "utf-16" },
    }),
    cmd = {
        "clangd",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=none",
    },

    on_attach = function()
        utils.nmap(utils.lmap, "<leader>lsh", utils.cmd("ClangdSwitchSourceHeader"), "Switch Header/Source")
    end,
})
vim.lsp.enable("clangd")

vim.lsp.config("lua_ls", {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    "${3rd}/luv/library",
                    -- "${3rd}/busted/library",
                },
            },
        })
        client.notify(vim.lsp.protocol.Methods.workspace_didChangeConfiguration, { settings = client.config.settings })
    end,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
        },
    },
})

vim.lsp.enable("lua_ls")

vim.lsp.config("ruff", {
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
    end,
})
vim.lsp.enable("ruff")

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                ignore = { "*" },
            },
        },
    },
})
vim.lsp.enable("basedpyright")

vim.lsp.enable("bashls")

vim.lsp.enable("templ")
vim.lsp.enable("ts_ls")
vim.lsp.enable("cssls")

vim.lsp.config("html", {
    filetypes = { "html", "templ" },
})
vim.lsp.enable("html")

vim.lsp.config("jsonls", {
    settings = {
        json = {
            validate = { enable = true },
            schemas = require("schemastore").json.schemas(),
        },
    },
})
vim.lsp.enable("jsonls")

vim.lsp.config("yamlls", {
    settings = {
        yaml = {
            schemas = require("schemastore").yaml.schemas(),
            schemaStore = {
                enable = false,
                url = "",
            },
        },
    },
})
vim.lsp.enable("yamlls")
