local M = {}

local map = function(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
end

M.map = map

M.cmd = function(cmd)
    return "<Cmd>" .. cmd .. "<CR>"
end

M.imap = function(...)
    map("i", ...)
end
M.nmap = function(...)
    map("n", ...)
end
M.tmap = function(...)
    map("t", ...)
end
M.nimap = function(...)
    map({ "n", "i" }, ...)
end
M.nxmap = function(...)
    map({ "n", "x" }, ...)
end
M.nximap = function(...)
    map({ "n", "x", "i" }, ...)
end

---@param keys string
M.feedkeys = function(keys)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(keys, true, false, true),
        "n",
        false
    )
end

--- Check if popup menu is open
M.pumvisible = function()
    return tonumber(vim.fn.pumvisible()) ~= 0
end

return M
