local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

local keymap = vim.keymap
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
opts.desc = "Run code lenses"
keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)

-- Hoogle search for the type signature of the definition under the cursor
opts.desc = "Hoogle search for the type signature of the definition under the cursor"
keymap.set("n", "<localleader>hs", ht.hoogle.hoogle_signature, opts)

-- Evaluate all code snippets
opts.desc = "Evaluate all code snippets"
keymap.set("n", "<localleader>ea", ht.lsp.buf_eval_all, opts)

-- Toggle a GHCi repl for the current package
opts.desc = "Toggle a GHCi repl for the current package"
keymap.set("n", "<localleader>rr", ht.repl.toggle, opts)

-- Restart hls
opts.desc = "Restart hls"
keymap.set("n", "<localleader>rs", ht.lsp.restart, opts)

-- Toggle a GHCi repl for the current buffer
opts.desc = "Toggle a GHCi repl for the current buffer"
keymap.set("n", "<localleader>rf", function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)

-- Quit the GHCi repl
opts.desc = "Quit the GHCi repl"
keymap.set("n", "<localleader>rq", ht.repl.quit, opts)

local opt_local = vim.opt_local
opt_local.softtabstop = 2
opt_local.shiftwidth = 2
opt_local.expandtab = true
