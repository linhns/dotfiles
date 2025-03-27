require("mini.files").setup({
    windows = {
        preview = true,
        width_preview = 50,
    },
})

local show_dotfiles = true

local filter_show = function(fs_entry)
    return true
end

local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
    end,
})

---@param from string
---@param to string
local lsp_on_rename = function(from, to)
    local changes = {
        files = {
            {
                oldUri = vim.uri_from_fname(from),
                newUri = vim.uri_from_fname(to),
            },
        },
    }

    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        if client.supports_method("workspace/willRenameFiles") then
            local resp = client.request_sync("workspace/willRenameFiles", changes, 1000, 0)
            if resp and resp.result ~= nil then
                vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
            end
        end
        if client.supports_method("workspace/didRenameFiles") then
            client.notify("workspace/didRenameFiles", changes)
        end
    end
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesActionRename",
    callback = function(event)
        lsp_on_rename(event.data.from, event.data.to)
    end,
})
