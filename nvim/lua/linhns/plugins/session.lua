local M = {
    "olimorris/persisted.nvim",
    lazy = false,
}

M.config = function()
    require("persisted").setup({
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        silent = false, -- silent nvim message when sourcing session file
        use_git_branch = false, -- create session files based on the branch of a git enabled repository
        default_branch = "main", -- the branch to load if a session file is not found for the current branch
        autosave = true, -- automatically save session files when exiting Neovim
        should_autosave = nil, -- function to determine if a session should be autosaved
        autoload = true, -- automatically load the session for the cwd on Neovim startup
        on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
        follow_cwd = true, -- change session file name to match current working directory if it changes
        allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
        ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
        ignored_branches = nil, -- table of branch patterns that are ignored for auto-saving and auto-loading
        telescope = {
            reset_prompt = true, -- Reset the Telescope prompt after an action?
            mappings = { -- table of mappings for the Telescope extension
                change_branch = "<c-b>",
                copy_session = "<c-c>",
                delete_session = "<c-d>",
            },
        },
    })

    local api = vim.api
    local group = api.nvim_create_augroup("PersistedHooks", {})
    local persisted = require("persisted")

    api.nvim_create_autocmd({ "User" }, {
        pattern = "PersistedSavePre",
        group = group,
        callback = function()
            vim.cmd("NvimTreeClose")
        end,
        desc = "Close NvimTree before saving session",
    })

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "PersistedTelescopeLoadPre",
        group = group,
        callback = function(session)
            -- Save the currently loaded session using a global variable
            require("persisted").save({ session = vim.g.persisted_loaded_session })

            -- Delete all of the open buffers
            vim.api.nvim_input("<ESC>:%bd!<CR>")
        end,
        desc = "Close all buffers before loading session via Telescope",
    })
end

return M
