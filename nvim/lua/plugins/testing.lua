require("neotest").setup({
    adapters = {
        require("neotest-golang")({
            dap_go_enabled = true,
        }),
    },
})
