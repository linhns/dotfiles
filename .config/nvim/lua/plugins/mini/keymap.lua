require("mini.keymap").setup()

local map_multistep = require("mini.keymap").map_multistep

map_multistep(
    "i",
    "<Tab>",
    { "minisnippets_next", "minisnippets_expand", "pmenu_next", "increase_indent", "jump_after_close" }
)
map_multistep("i", "<S-Tab>", { "minisnippets_prev", "pmenu_prev", "decrease_indent", "jump_before_open" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })
