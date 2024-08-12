local diagnostic_icons =
    { ERROR = " ", WARN = " ", HINT = "󰠠 ", INFO = " " }
for type, icon in pairs(diagnostic_icons) do
    local hl = "DiagnosticSign" .. type:sub(1, 1) .. type:sub(2):lower()
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
        spacing = 2,
        format = function(diagnostic)
            local icon =
                diagnostic_icons[vim.diagnostic.severity[diagnostic.severity]]
            local msg = vim.split(diagnostic.message, "\n")[1]
            return string.format("%s %s ", icon, msg)
        end,
    },
    float = {
        source = "if_many",
        prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(" %s ", diagnostic_icons[level])
            return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
        end,
    },
    signs = false,
})

local show_handler = vim.diagnostic.handlers.virtual_text.show
assert(show_handler)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
    show = function(ns, bufnr, diagnostics, opts)
        table.sort(diagnostics, function(lhs, rhs)
            return lhs.severity > rhs.severity
        end)
        return show_handler(ns, bufnr, diagnostics, opts)
    end,
    hide = hide_handler,
}

local keyutils = require("utils.functions.keymaps")
local cmd = keyutils.cmd

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    keyutils.nmap(
        "<leader>lgr",
        cmd("Pick lsp scope='references'"),
        "Go to References"
    )
    keyutils.nmap(
        "<leader>lgD",
        cmd("Pick lsp scope='declaration'"),
        "Go to Declaration"
    )
    keyutils.nmap(
        "<leader>lgd",
        cmd("Pick lsp scope='definition'"),
        "Go to Definition"
    )
    keyutils.nmap(
        "<leader>lgt",
        cmd("Pick lsp scope='type_definition'"),
        "Go to Type Definition"
    )
    keyutils.nmap(
        "<leader>ls",
        cmd("Pick lsp scope='document_symbol'"),
        "Document Symbol"
    )
    keyutils.nmap(
        "<leader>lw",
        cmd("Pick lsp scope='workspace_symbol'"),
        "Workspace Symbol"
    )

    if client.supports_method("textDocument/signatureHelp") then
        keyutils.imap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    end

    if client.supports_method("textDocument/rename") then
        keyutils.nmap("<leader>lrn", vim.lsp.buf.rename, "Rename Symbol")
    end

    if client.supports_method("textDocument/inlayHint") then
        local inlay_hint_group =
            vim.api.nvim_create_augroup("linhns/inlayhints", { clear = false })
        vim.defer_fn(function()
            local mode = vim.api.nvim_get_mode().mode
            vim.lsp.inlay_hint.enable(
                mode == "n" or mode == "v",
                { bufnr = bufnr }
            )
        end, 500)

        vim.api.nvim_create_autocmd("InsertEnter", {
            group = inlay_hint_group,
            desc = "Disable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            group = inlay_hint_group,
            desc = "Enable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end,
        })
    end

    if client.supports_method("textDocument/documentHighlight") then
        local under_cursor_highlights_group = vim.api.nvim_create_augroup(
            "linhns/cursor_highlights",
            { clear = false }
        )
        vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
            group = under_cursor_highlights_group,
            desc = "Highlight references under the cursor",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd(
            { "CursorMoved", "InsertEnter", "BufLeave" },
            {
                group = under_cursor_highlights_group,
                desc = "Clear highlight references",
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            }
        )
    end

    if client.supports_method("textDocument/codeAction") then
        keyutils.nmap(
            "<leader>lca",
            vim.lsp.buf.code_action,
            "Display Code Actions"
        )
    end

    if client.supports_method("textDocument/prepareHierarchy") then
        keyutils.nmap(
            "<leader>lch",
            vim.lsp.buf.incoming_calls,
            "Show Call Hierarchy"
        )
    end

    if client.server_capabilities.codeLensProvider then
        local codelens_group =
            vim.api.nvim_create_augroup("linhns/codelens", { clear = false })
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            group = codelens_group,
            desc = "Refresh codelens",
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
        keyutils.nmap("<leader>lcl", vim.lsp.codelens.run, "Run code lens")
    end

    keyutils.nmap(",rs", cmd("LspRestart"), "Restart LSP")

    -- Clangd specifics
    if client.supports_method("textDocument/switchSourceHeader") then
        keyutils.nmap(
            ",sh",
            cmd("ClangdSwitchSourceHeader"),
            "Switch source/header"
        )
    end
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers["client/registerCapability"]
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        on_attach(client, bufnr)
    end,
})
