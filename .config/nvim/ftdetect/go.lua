vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.gotmpl",
    callback = function()
        vim.bo.filetype = "gotmpl"
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.gohtml",
    callback = function()
        vim.bo.filetype = "gohtml"
    end,
})
