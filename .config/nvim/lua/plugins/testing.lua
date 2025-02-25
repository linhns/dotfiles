require("neotest").setup({
    adapters = {
        require("neotest-golang")({
            dap_go_enabled = true,
        }),
        require("neotest-vitest")({
            filter_dir = function(name, rel_path, root)
                return name ~= "node_modules"
            end,
        }),
    },
})
