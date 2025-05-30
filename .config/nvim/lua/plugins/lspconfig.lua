local lspconfig = require("lspconfig")
local utils = require("utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig["gopls"].setup({
    capabilities = capabilities,
    cmd = { "gopls" },
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

lspconfig["clangd"].setup({
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

lspconfig["lua_ls"].setup({
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

lspconfig["ruff"].setup({
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
    end,
})

lspconfig["pylsp"].setup({
    settings = {
        pylsp = {
            plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
            },
        },
    },
})

lspconfig["bashls"].setup({})

lspconfig["templ"].setup({})
lspconfig["ts_ls"].setup({})
lspconfig["html"].setup({
    filetypes = { "html", "templ" },
})
lspconfig["cssls"].setup({})
lspconfig["jsonls"].setup({
    settings = {
        json = {
            validate = { enable = true },
        },
    },
    on_new_config = function(config)
        config.settings.json.schemas = config.settings.json.schemas or {}
        vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
    end,
})
