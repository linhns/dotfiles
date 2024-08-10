return {
    "echasnovski/mini.icons",
    version = false,
    lazy = true,
    opts = {},
    init = function()
        local mini_icons = require("mini.icons")
        mini_icons.mock_nvim_web_devicons()
        mini_icons.tweak_lsp_kind()
    end,
}
