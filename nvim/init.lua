_G.Config = {}

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local cmd = function(cmd)
    return function()
        vim.cmd(cmd)
    end
end
local load = function(spec, opts)
    return function()
        opts = opts or {}
        local slash = string.find(spec, "/[^/]*$") or 0
        local name = opts.init or string.sub(spec, slash + 1)
        if slash ~= 0 then
            add(vim.tbl_deep_extend("force", { source = spec }, opts.add or {}))
        end
        require(name)
        if opts.setup then
            require(name).setup(opts.setup)
        end
    end
end

now(load("settings"))
now(load("keymaps"))
now(load("autocmds"))

add({ name = "mini.nvim" })
now(function()
    add({
        source = "rockyzhang24/arctic.nvim",
        checkout = "v2",
        depends = {
            "rktjmp/lush.nvim",
        },
    })
end)
now(cmd("colorscheme vscode"))

now(load("plugins.mini.basics"))
now(load("plugins.mini.icons"))
now(load("plugins.mini.sessions"))
now(load("mini.starter", { setup = {} }))

later(load("mini.pairs", { setup = {} }))
later(load("lsp"))

later(load("mini.statusline", { setup = {} }))
later(load("mini.tabline", { setup = {} }))
later(load("mini.trailspace", { setup = {} }))
later(load("mini.move", { setup = {} }))
later(load("mini.jump", { setup = {} }))
later(load("mini.splitjoin", { setup = {} }))
later(load("mini.surround", { setup = {} }))
later(load("mini.operators", { setup = {} }))
later(load("mini.git", { setup = {} }))
later(load("mini.bufremove", { setup = {} }))
later(load("mini.extra", { setup = {} }))
later(load("mini.visits", { setup = {} }))

later(load("plugins.mini.ai"))
later(load("plugins.mini.bracketed"))
later(load("plugins.mini.clue"))
later(load("plugins.mini.indentscope"))
later(load("plugins.mini.notify"))
later(load("plugins.mini.diff"))
later(load("plugins.mini.files"))
later(load("plugins.mini.pick"))

later(function()
    add({
        source = "Bekaboo/dropbar.nvim",
    })
end)

later(load("stevearc/dressing.nvim", { init = "plugins.dressing" }))
later(load("stevearc/conform.nvim", { init = "plugins.formatting" }))
later(load("mfussenegger/nvim-lint", { init = "plugins.linting" }))
later(add("b0o/schemastore.nvim"))

later(load("nvim-treesitter/nvim-treesitter", {
    init = "plugins.treesitter",
    add = {
        hooks = {
            post_checkout = cmd("TSUpdate"),
        },
    },
}))
later(function()
    add("nvim-treesitter/nvim-treesitter-textobjects")
end)
later(load("nvim-treesitter/nvim-treesitter-context", {
    init = "treesitter-context",
    setup = {},
}))

later(load("windwp/nvim-ts-autotag", {
    init = "plugins.autotag",
}))

later(load("zbirenbaum/copilot.lua", {
    init = "plugins.copilot",
}))

later(load("williamboman/mason.nvim", {
    init = "plugins.mason",
}))

later(load("neovim/nvim-lspconfig", {
    init = "plugins.lspconfig",
}))

later(load("mfussenegger/nvim-dap", {
    init = "plugins.dap",
    add = {
        depends = {
            "leoluz/nvim-dap-go",
        },
    },
}))

later(load("rcarriga/nvim-dap-ui", {
    init = "plugins.dap-ui",
    add = {
        depends = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        },
    },
}))

later(load("nvim-neotest/neotest", {
    init = "plugins.testing",
    add = {
        depends = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "fredrikaverpil/neotest-golang",
        },
    },
}))

later(load("olexsmir/gopher.nvim", {
    init = "plugins.gopher",
    add = {
        depends = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
}))
