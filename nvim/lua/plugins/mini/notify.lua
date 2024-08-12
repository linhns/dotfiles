local mininotify = require("mini.notify")
mininotify.setup({})
vim.notify = mininotify.make_notify()
