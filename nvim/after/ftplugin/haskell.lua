local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

local keymap = vim.keymap
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)
-- Hoogle search for the type signature of the definition under the cursor
keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
-- Evaluate all code snippets
keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
-- Toggle a GHCi repl for the current package
keymap.set("n", "<leader>rr", ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
keymap.set("n", "<leader>rf", function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
keymap.set("n", "<leader>rq", ht.repl.quit, opts)

keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

keymap.set("n", "K", vim.lsp.buf.hover, opts)

local opt_local = vim.opt_local
opt_local.softtabstop = 2
opt_local.shiftwidth = 2
opt_local.expandtab = true
