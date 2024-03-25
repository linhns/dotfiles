local M = {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    event = { "VimEnter" },

}

M.opts = {
    filetype_exclude = {
        "help",
        "Trouble",
        "mason",
        "lazy",
        "NvimTree"
    },
    provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
    end
}

M.config = function(_, opts)
    local keymap = vim.keymap
    local ufo = require("ufo")

    -- stylua: ignore start
    keymap.set('n', 'zR', ufo.openAllFolds, { desc = "Open All Folds" })
    keymap.set('n', 'zM', ufo.closeAllFolds, { desc = "Close All Folds" })
    -- stylua: ignore end
    --
    local api = vim.api
    api.nvim_create_autocmd("FileType", {
        group = api.nvim_create_augroup("local_detach_ufo", { clear = true }),
        pattern = opts.filetype_exclude,
        callback = function()
            ufo.detach()
        end
    })

    ufo.setup(opts)
end

return M
