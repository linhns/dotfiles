local M = {

    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-vim-test",
        "mrcjkb/neotest-haskell",
        "vim-test/vim-test",
    },
    config = function()
        local api = vim.api
        local neotest_ns = api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local msg = diagnostic.message
                        :gsub("\n", " ")
                        :gsub("\r", " ")
                        :gsub("\t", " ")
                        :gsub("%s+", " ")
                        :gsub("^%s+", " ")
                    return msg
                end,
            },
        }, neotest_ns)

        require("neotest").setup({
            adapters = {
                require("neotest-haskell"),
                require("neotest-vim-test")({
                    ignore_file_types = { "haskell", "vim" },
                }),
            },
        })

        local keymap = vim.keymap
        local mapopts = { noremap = true, silent = true, nowait = true }
        local neotest = require("neotest")

        keymap.set("n", "<localleader>tf", function()
            neotest.run.run(vim.fn.expand("%"))
        end, mapopts)

        keymap.set("n", "<localleader>tS", function()
            neotest.summary.toggle()
        end, mapopts)

        keymap.set("n", "<localleader>ts", function()
            neotest.run.stop()
        end, mapopts)

        keymap.set("n", "<localleader>tr", function()
            neotest.run.run()
        end, mapopts)

        keymap.set("n", "<localleader>tl", function()
            neotest.run.run_last({ enter = true })
            neotest.output.open({ enter = true, last_run = true })
        end, mapopts)

        keymap.set("n", "<localleader>to", function()
            neotest.output.open({ enter = true, last_run = true })
        end, mapopts)
    end,
}

return M
