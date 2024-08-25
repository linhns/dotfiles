vim.highlight.priorities.semantic_tokens = 95

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

local utils = require("utils")
local lmap = utils.lmap
local nmap = function(...)
    utils.nmap(lmap, ...)
end
local imap = function(...)
    utils.imap(lmap, ...)
end
local cmd = utils.cmd
local pumvisible = utils.pumvisible
local feedkeys = utils.feedkeys

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    nmap("<leader>lgr", cmd("Pick lsp scope='references'"), "Go to References")
    nmap(
        "<leader>lgD",
        cmd("Pick lsp scope='declaration'"),
        "Go to Declaration"
    )
    nmap("<leader>lgd", cmd("Pick lsp scope='definition'"), "Go to Definition")
    nmap(
        "<leader>lgt",
        cmd("Pick lsp scope='type_definition'"),
        "Go to Type Definition"
    )
    nmap(
        "<leader>ls",
        cmd("Pick lsp scope='document_symbol'"),
        "Document Symbol"
    )
    nmap(
        "<leader>lw",
        cmd("Pick lsp scope='workspace_symbol'"),
        "Workspace Symbol"
    )

    if client.supports_method("textDocument/signatureHelp") then
        imap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    end

    if client.supports_method("textDocument/rename") then
        nmap("<leader>lrn", vim.lsp.buf.rename, "Rename Symbol")
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
        nmap("<leader>lca", vim.lsp.buf.code_action, "Display Code Actions")
    end

    if client.supports_method("textDocument/prepareHierarchy") then
        nmap("<leader>lch", vim.lsp.buf.incoming_calls, "Show Call Hierarchy")
    end

    if client.supports_method("textDocument/codeLens") then
        local codelens_group =
            vim.api.nvim_create_augroup("linhns/codelens", { clear = false })
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            group = codelens_group,
            desc = "Refresh codelens",
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
        nmap("<leader>lcl", vim.lsp.codelens.run, "Run code lens")
    end

    if client.supports_method("textDocument/completion") then
        vim.lsp.completion.enable(
            true,
            client.id,
            bufnr,
            { autotrigger = true }
        )

        imap("<CR>", function()
            return pumvisible() and "<C-y>" or require("mini.pairs").cr()
        end, "Accept Completion", { expr = true })

        imap("/", function()
            return pumvisible() and "<C-e>" or "/"
        end, "Dismiss Completion Menu", { expr = true })

        imap("<C-n>", function()
            if pumvisible() then
                feedkeys("<C-n>")
            else
                if next(vim.lsp.get_clients({ bufnr = 0 })) then
                    vim.lsp.completion.trigger()
                else
                    if vim.bo.omnifunc == "" then
                        feedkeys("<C-x><C-n>")
                    else
                        feedkeys("<C-x><C-o>")
                    end
                end
            end
        end, "Trigger/select next completion")

        imap("<C-u>", "<C-x><C-n>", "Buffer completions")

        lmap({ "i", "s" }, "<Tab>", function()
            if pumvisible() then
                feedkeys("<C-n>")
            elseif vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            else
                feedkeys("<Tab>")
            end
        end, "Navigate next snippet tabstop/completion")

        lmap({ "i", "s" }, "<S-Tab>", function()
            if pumvisible() then
                feedkeys("<C-p>")
            elseif vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                feedkeys("<S-Tab>")
            end
        end, "Navigate previous snippet tabstop/completion")

        lmap({ "s" }, "<BS>", "<C-o>s")
    end

    nmap("<leader>lrs", cmd("LspRestart"), "Restart LSP")

    -- Clangd specifics
    if client.supports_method("textDocument/switchSourceHeader") then
        nmap(",sh", cmd("ClangdSwitchSourceHeader"), "Switch source/header")
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
