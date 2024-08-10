-- Sane cursorline
local cursor_group = vim.api.nvim_create_augroup("cursorline", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    command = "set cursorline",
    group = cursor_group,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    pattern = "*",
    command = "set nocursorline",
    group = cursor_group,
})

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("linhns/treesitter", { clear = true }),
    desc = "Set up treesitter",
    callback = function()
        if require("nvim-treesitter.parsers").has_parser() then
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        else
            vim.opt.foldmethod = "syntax"
        end
    end,
})
