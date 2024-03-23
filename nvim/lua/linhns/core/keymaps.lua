-- Copy to clipboard
vim.keymap.set({'n', 'v'}, ',y', [["+y]])

-- Paste from clipboard
vim.keymap.set({'n', 'v'}, ',p', [["+p]])

-- Delete without changing registers
vim.keymap.set({'n', 'v'}, ',d', [["_d]])
vim.keymap.set({'n', 'v'}, 'x', [["_x]])

-- No arrow keys
vim.keymap.set({'n', 'v', 'i'}, '<up>', '<nop>')
vim.keymap.set({'n', 'v', 'i'}, '<down>', '<nop>')
vim.keymap.set({'n', 'v', 'i'}, '<left>', '<nop>')
vim.keymap.set({'n', 'v', 'i'}, '<right>', '<nop>')

-- Centered search movements
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Centered page movements
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
