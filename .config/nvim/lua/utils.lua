local M = {}

local misc = require('mini.misc')
local now = function(f) misc.safely('now', f) end
local later = function(f) misc.safely('later', f) end

local now_if_args = vim.fn.argc(-1) > 0 and now or later
local on_event = function(ev, f) misc.safely('event:' .. ev, f) end
local on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

--- Create an autocommand group
local augroup = vim.api.nvim_create_augroup

local autocmd = vim.api.nvim_create_autocmd

local gr = augroup('onpackchanged', {})
local on_packchanged = function(plugin_name, kinds, callback, desc)
    if vim.fn.has('nvim-0.12') == 0 then return end
    local f = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
        if not ev.data.active then vim.cmd.packadd(plugin_name) end
        callback()
    end

    autocmd('PackChanged', { group = gr, pattern = '*', callback = f, desc = desc })
end
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

M.augroup = augroup
M.autocmd = autocmd

M.now = now
M.now_if_args = now_if_args
M.later = later
M.on_event = on_event
M.on_filetype = on_filetype
M.on_packchanged = on_packchanged

M.map = map
M.lmap = lmap

--- @param cmd string
M.cmd = function(cmd) return '<Cmd>' .. cmd .. '<CR>' end

M.imap = function(mapper, ...) mapper('i', ...) end
M.nmap = function(mapper, ...) mapper('n', ...) end
M.tmap = function(mapper, ...) mapper('t', ...) end
M.nimap = function(mapper, ...) mapper({ 'n', 'i' }, ...) end
M.nxmap = function(mapper, ...) mapper({ 'n', 'x' }, ...) end
M.nximap = function(mapper, ...) mapper({ 'n', 'x', 'i' }, ...) end

---@param keys string
M.feedkeys = function(keys) vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false) end

--- Check if popup menu is open
M.pumvisible = function() return tonumber(vim.fn.pumvisible()) ~= 0 end

--- Set highlight group
M.hi = function(name, data) vim.api.nvim_set_hl(0, name, data) end

return M
