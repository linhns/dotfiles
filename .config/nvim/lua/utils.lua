local M = {}

local map = function(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
end

local lmap = function(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.buffer = 0
    map(mode, lhs, rhs, desc, opts)
end

M.map = map
M.lmap = lmap

--- @param cmd string
M.cmd = function(cmd)
    return "<Cmd>" .. cmd .. "<CR>"
end

M.imap = function(mapper, ...)
    mapper("i", ...)
end
M.nmap = function(mapper, ...)
    mapper("n", ...)
end
M.tmap = function(mapper, ...)
    mapper("t", ...)
end
M.nimap = function(mapper, ...)
    mapper({ "n", "i" }, ...)
end
M.nxmap = function(mapper, ...)
    mapper({ "n", "x" }, ...)
end
M.nximap = function(mapper, ...)
    mapper({ "n", "x", "i" }, ...)
end

---@param keys string
M.feedkeys = function(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)
end

--- Check if popup menu is open
M.pumvisible = function()
    return tonumber(vim.fn.pumvisible()) ~= 0
end

--- Create an autocommand group
M.augroup = function(name)
    vim.api.nvim_create_augroup(name, { clear = true })
end

--- Set highlight group
M.hi = function(name, data)
    vim.api.nvim_set_hl(0, name, data)
end

return M
