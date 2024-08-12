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

return M
