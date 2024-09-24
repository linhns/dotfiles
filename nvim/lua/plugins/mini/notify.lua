local mininotify = require("mini.notify")

mininotify.setup({
    window = {
        max_width_share = 0.4,
    },
})

vim.notify = mininotify.make_notify()
