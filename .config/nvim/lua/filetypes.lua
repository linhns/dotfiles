vim.filetype.add({
    extension = {
        caddyfile = "caddyfile",
        Caddyfile = "caddyfile",
        zstyles = "zsh",
    },
    filename = {
        caddyfile = "caddyfile",
        Caddyfile = "caddyfile",
    },
    pattern = {
        ["^Caddyfile%."] = { "caddyfile", { priority = -math.huge } },
    },
})
