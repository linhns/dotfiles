local M = {
    'neovim/nvim-lspconfig',
    event = {
        'BufReadPre',
        'BufNewFile'
    },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        {
            'antosha417/nvim-lsp-file-operations',
            config = true
        },
    }
}

M.config = function()
    local lspconfig = require('lspconfig')

    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    local keymap = vim.keymap

    local opts = {
        noremap = true,
        silent = true
    }

    local on_attach = function(client, bufnr)
        opts.desc = 'Show LSP references'
        keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

        opts.desc = 'Go to declaration'
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        opts.desc = 'Show LSP definitions'
        keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

        opts.desc = 'Show LSP implementations'
        keymap.set('n', 'gR', '<cmd>Telescope lsp_implementations<CR>', opts)

        opts.desc = 'Show LSP type definitions'
        keymap.set('n', 'gR', '<cmd>Telescope lsp_type_definitions<CR>', opts)

        opts.desc = 'Display code actions'
        keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)

        opts.desc = 'Rename symbol'
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        opts.desc = 'Show buffers diagnostics'
        keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

        opts.desc = 'Show line diagnostics'
        keymap.set('n', '<leader>d', vim.diagnostics.open_float, opts)

        opts.desc = 'Go to next diagnostic'
        keymap.set('n', ']d', vim.diagnostics.goto_next, opts)

        opts.desc = 'Go to previous diagnostic'
        keymap.set('n', '[d', vim.diagnostics.goto_prev, opts)

        opts.desc = 'Show documentation'
        keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        opts.desc = 'Restart LSP'
        keymap.set('n', '<leader>rs', '<cmd>LspRestart<CR>', opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    lspconfig['lua_ls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    }
                }
            }
        }
    })

    lspconfig['clangd'].setup{}

end

return M
