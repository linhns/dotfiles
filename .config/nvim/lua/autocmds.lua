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

vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
    callback = function()
        if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
            vim.schedule(function()
                vim.cmd.nohlsearch()
            end)
        end
    end,
})

-- Highlighting priorities
local hl_priorities_group = vim.api.nvim_create_augroup("linhns/hl-priorities", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = hl_priorities_group,
    pattern = "*.go",
    callback = function()
        vim.highlight.priorities.semantic_tokens = 95
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = hl_priorities_group,
    pattern = "*.gohtml",
    callback = function()
        vim.highlight.priorities.semantic_tokens = 125
    end,
})
