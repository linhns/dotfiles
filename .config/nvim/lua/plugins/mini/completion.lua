require("mini.completion").setup({
    lsp_completion = { source_func = "omnifunc", auto_setup = false },
})

local filetypes = {
    "minifiles",
    "snacks_picker_input",
    "snacks_input",
}

local ag = vim.api.nvim_create_augroup("MiniCompletionDisable", { clear = true })

local f = function(args)
    local ft = vim.bo[args.buf].filetype
    if vim.tbl_contains(filetypes, ft) then
        vim.b[args.buf].minicompletion_disable = true
    end
end
vim.api.nvim_create_autocmd("FileType", { group = ag, callback = f })
