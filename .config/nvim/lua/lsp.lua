vim.lsp.enable({
    'gopls',
    'clangd',
    'lua_ls',
    'ruff',
    'ty',
    'bashls',
    'templ',
    'ts_ls',
    'cssls',
    'html',
    'jsonls',
    'yamlls',
    'dockerls',
    'somesass_ls',
    'protols',
    'tailwindcss',
})

local utils = require('utils')
local lmap = utils.lmap
local nmap = function(...) utils.nmap(lmap, ...) end
local cmd = utils.cmd

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    nmap('gd', cmd("lua require('snacks').picker.lsp_definitions()"), 'Go to Definition')
    nmap('gD', cmd("lua require('snacks').picker.lsp_declarations()"), 'Go to Declaration')
    nmap('grr', cmd("lua require('snacks').picker.lsp_references()"), 'Go to References')
    nmap('gI', cmd("lua require('snacks').picker.lsp_implementations()"), 'Go to Implementation')
    nmap('gy', cmd("lua require('snacks').picker.lsp_type_definitions()"), 'Go to Type Definition')
    nmap('gO', cmd("lua require('snacks').picker.lsp_symbols()"), 'Document Symbol')
    nmap('gW', cmd("lua require('snacks').picker.lsp_workspace_symbols()"), 'Workspace Symbol')

    if client:supports_method('textDocument/inlayHint') then vim.lsp.inlay_hint.enable(false) end

    if client:supports_method('textDocument/documentHighlight') then
        local gr = utils.augroup('linhns/document_highlight', {})
        utils.autocmd({ 'CursorHold', 'InsertLeave' }, {
            group = gr,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        utils.autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            group = gr,
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if client:supports_method('textDocument/codeLens') then vim.lsp.codelens.enable(false, { bufnr = bufnr }) end
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers['client/registerCapability']
vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then return end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        on_attach(client, bufnr)
    end,
})
