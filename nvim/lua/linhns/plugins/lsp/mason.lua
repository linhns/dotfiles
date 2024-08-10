local M = {
    "williamboman/mason.nvim",
    dependencies = {},
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "→",
                package_uninstalled = "✗",
            },
        },
    },
}

return M
