local minipick = require("mini.pick")
require("mini.pick").setup({
	window = {
		config = {
			border = "single",
		},
	},
})

vim.ui.select = minipick.ui_select
