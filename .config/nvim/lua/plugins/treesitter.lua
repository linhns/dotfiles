local utils = require('utils')

local gr = utils.augroup('linhns/treesitter', {})

local languages = {
    'go',
    'gomod',
    'gowork',
    'gosum',
    'python',
    'lua',
    'c',
    'cpp',
    'vim',
    'vimdoc',
    'markdown',
    'markdown_inline',
    'html',
    'javascript',
    'typescript',
    'tsx',
    'css',
    'templ',
}

require('nvim-treesitter').install(languages)

local filetypes = vim.iter(languages):map(vim.treesitter.language.get_filetypes):flatten():totable()

vim.list_extend(filetypes, { 'gohtml' })

utils.autocmd('FileType', {
    group = gr,
    pattern = filetypes,
    callback = function(event)
        vim.treesitter.start(event.buf)
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
    desc = 'Enable treesitter',
})

vim.treesitter.language.register('html', 'gohtml')
