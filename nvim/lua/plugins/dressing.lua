require("dressing").setup({
	input = {
		prefer_width = 0.3,
		get_config = function(opts)
			if opts.prompt == require("plugins.mini.sessions").save_prompt then
				return {
					relative = "editor",
				}
			end
		end,
	},
	select = {
		enabled = false,
	},
})
