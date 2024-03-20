-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Turn on termguicolors
if not vim.o.termguicolors then
    vim.opt.termguicolors = true
end

-- Update time
vim.opt.updatetime = 400

-- Columns
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "2"

-- Lazyredraw
vim.opt.lazyredraw = true

-- Backup options
vim.opt.writebackup = false

-- Change buffer without saving
vim.opt.hidden = true

-- Statusline
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Tabline
vim.opt.showtabline = 2

-- Searching options
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Brackets
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Text formatting
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

-- Line breaks
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.colorcolumn = '+1'

-- Mouse support
vim.opt.mouse = 'a'

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Wildmenu
vim.opt.wildignore = '*.o,*.obj,*.pyc,*.swp,*.bak,*/.git/*,*/.svn/*'
