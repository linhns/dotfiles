local miniindentscope = require("mini.indentscope")
miniindentscope.setup({
	draw = {
		animation = miniindentscope.gen_animation.none(),
	},
	mappings = {
		object_scope = "",
		object_scope_with_border = "",

		goto_top = "",
		goto_bottom = "",
	},
})
