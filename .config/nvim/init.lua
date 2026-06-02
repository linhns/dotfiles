_G.Config = {}

vim.pack.add({
    'https://github.com/nvim-mini/mini.nvim',
})

local utils = require('utils')

require('settings')
require('keymaps')
require('autocmds')
require('filetypes')
require('diagnostics')

local now, now_if_args, later = utils.now, utils.now_if_args, utils.later
local on_packchanged = utils.on_packchanged

now(function()
    vim.pack.add({
        'https://github.com/catppuccin/nvim',
    })

    require('catppuccin').setup({
        no_underline = true,
    })
end)

now(function() vim.cmd('colorscheme catppuccin-mocha') end)

now(function() require('plugins.mini.basics') end)
now(function() require('plugins.mini.icons') end)
now(function() require('plugins.mini.sessions') end)
now(function() require('mini.starter').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.tabline').setup() end)

now_if_args(function() require('plugins.mini.completion') end)

later(function() require('mini.extra').setup() end)
later(function() require('mini.align').setup() end)
later(function() require('mini.bufremove').setup() end)
later(function() require('mini.comment').setup() end)
later(function() require('mini.git').setup() end)
later(function() require('mini.jump').setup() end)
later(function() require('mini.move').setup() end)
later(function() require('mini.pairs').setup() end)
later(function() require('mini.splitjoin').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.trailspace').setup() end)
later(function() require('mini.visits').setup() end)

later(function() require('plugins.mini.ai') end)
later(function() require('plugins.mini.bracketed') end)
later(function() require('plugins.mini.clue') end)
later(function() require('plugins.mini.diff') end)
later(function() require('plugins.mini.files') end)
later(function() require('plugins.mini.keymap') end)
later(function() require('plugins.mini.indentscope') end)
later(function() require('plugins.mini.notify') end)
later(function() require('plugins.mini.operators') end)
later(function() require('plugins.mini.snippets') end)

later(function()
    vim.pack.add({
        'https://github.com/folke/snacks.nvim',
    })
    require('plugins.qol')
end)

later(function()
    vim.pack.add({
        'https://github.com/stevearc/conform.nvim',
    })
    require('plugins.formatting')
end)

later(function()
    vim.pack.add({
        'https://github.com/mfussenegger/nvim-lint',
    })
    require('plugins.linting')
end)

later(function()
    vim.pack.add({
        'https://github.com/b0o/schemastore.nvim',
    })
end)

now_if_args(function() require('lsp') end)

later(function()
    vim.pack.add({
        'https://github.com/Bekaboo/dropbar.nvim',
    })
end)

later(function()
    vim.pack.add({
        'https://github.com/zbirenbaum/copilot.lua',
    })

    require('plugins.copilot')
end)

later(function()
    vim.pack.add({
        'https://github.com/mason-org/mason.nvim',
        'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
    })

    require('plugins.mason')
    require('plugins.mason-tool-installer')
end)

later(function()
    vim.pack.add({
        'https://github.com/neovim/nvim-lspconfig',
    })
end)

now_if_args(function()
    on_packchanged('nvim-treesitter', { 'update' }, function() vim.cmd('TSUpdate') end, ':TSUpdate')

    vim.pack.add({
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    })

    require('plugins.treesitter')
end)

later(function()
    vim.pack.add({
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/windwp/nvim-ts-autotag',
    })

    require('plugins.autotag')
end)

later(function()
    vim.pack.add({
        'https://github.com/nvim-neotest/nvim-nio',
        'https://github.com/leoluz/nvim-dap-go',
        'https://github.com/mfussenegger/nvim-dap-python',
        'https://github.com/mfussenegger/nvim-dap',
        'https://github.com/rcarriga/nvim-dap-ui',
    })

    require('plugins.debugger')
    require('plugins.dap-ui')
end)

later(function()
    vim.pack.add({
        'https://github.com/nvim-neotest/nvim-nio',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/fredrikaverpil/neotest-golang',
        'https://github.com/marilari88/neotest-vitest',
        'https://github.com/nvim-neotest/neotest',
    })

    require('plugins.testing')
end)

later(function()
    vim.pack.add({
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/olexsmir/gopher.nvim',
    })

    require('plugins.gopher')
end)
