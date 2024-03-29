return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
        input = {
            get_config = function(opts)
                if opts.prompt == vim.g.session_save_prompt then
                    return {
                        relative = "editor",
                    }
                end
            end,
        },
    },
}
