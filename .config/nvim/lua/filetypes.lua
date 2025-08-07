vim.filetype.add({
    extension = {
        caddyfile = "caddyfile",
        Caddyfile = "caddyfile",
    },
    filename = {
        caddyfile = "caddyfile",
        Caddyfile = "caddyfile",
    },
    pattern = {
        ["^Caddyfile%."] = { "caddyfile", { priority = -math.huge } },
    },
})
