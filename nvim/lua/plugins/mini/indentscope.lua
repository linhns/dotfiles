local indentscope = require("mini.indentscope")
indentscope.setup({
    draw = {
        animation = indentscope.gen_animation.none(),
    },
    options = {
        try_as_border = true,
    },
})
