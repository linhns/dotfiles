local M = {
    "echasnovski/mini.sessions",
    version = "*",
}

M.config = function()
    local sessions = require("mini.sessions")
    sessions.setup({
        -- Whether to read latest session if Neovim opened without file arguments
        autoread = true,

        -- Whether to write current session before quitting Neovim
        autowrite = true,

        -- Directory where global sessions are stored (use `''` to disable)
        directory = vim.fn.stdpath("data") .. "/sessions", --<"session" subdir of user data directory from |stdpath()|>,

        -- File for local session (use `''` to disable)
        file = "",

        -- Whether to force possibly harmful actions (meaning depends on function)
        force = { read = false, write = true, delete = true },

        -- Hook functions for actions. Default `nil` means 'do nothing'.
        hooks = {
            -- Before successful action
            pre = { read = nil, write = nil, delete = nil },
            -- After successful action
            post = { read = nil, write = nil, delete = nil },
        },

        -- Whether to print session path after action
        verbose = { read = true, write = true, delete = true },
    })

    local funcs = {
        read = function()
            sessions.select("read")
        end,
        write = function()
            sessions.select("write")
        end,
        delete = function()
            sessions.select("delete")
        end,
        save = function()
            local default_session_name = string.match(vim.v.this_session, "[^/\\]+$")
            -- stylua: ignore
            vim.ui.input(
                {
                    prompt = vim.g.session_save_prompt,
                    default = default_session_name
                },
                function(name)
                    -- Try to enter empty will save a name indicating the current directory
                    if name == "" then
                        local separator = package.config:sub(1, 1)
                        local cwd = vim.loop.cwd()
                        name = string.gsub(cwd, separator, "_")
                    end
                    sessions.write(name)
                end
            )
        end,
    }

    local keymap = vim.keymap
    keymap.set("n", "<leader>sr", funcs.read, { desc = "Read session" })
    keymap.set("n", "<leader>sd", funcs.delete, { desc = "Delete session" })
    keymap.set("n", "<leader>sw", funcs.write, { desc = "Overwrite session" })
    keymap.set("n", "<leader>ss", funcs.save, { desc = "Save session" })
end

return M
