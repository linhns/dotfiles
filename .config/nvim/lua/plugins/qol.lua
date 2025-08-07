require("snacks").setup({
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    input = {
        enabled = true,
    },
    picker = {
        enabled = true,
    },
    profile = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    statuscolumn = { enabled = true },
    styles = {
        input = {
            keys = {
                i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
            },
        },
    },
})
