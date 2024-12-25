-- stylua: ignore start
-- See rktjmp/lush-template for more details on what can go in this file.

vim.opt.background = "dark"
vim.g.colors_name = "vscode"

-- First we will need lush, and the colorscheme we wish to modify
local lush = require("lush")
local arctic = require("lush_theme.arctic")

-- we can apply modifications on top of the existing colorscheme
local spec = lush.extends({ arctic }).with(function()
    return {
        -- Remove underline from tabline
        TabLine { fg = arctic.TabLine.fg, bg = arctic.TabLine.bg, sp = arctic.TabLine.sp, underline = false },
        TabLineSel { fg = arctic.TabLineSel.fg, bg = arctic.TabLineSel.bg, sp = arctic.TabLineSel.sp, underline = false, bold = true },
        TabLineFill { bg = arctic.TabLineFill.bg, sp = arctic.TabLineFill.sp, underline = false },

        -- Dim Copilot suggestions
        CopilotSuggestion { arctic.NonText, gui = "italic" },
        CopilotAnnotation { arctic.NonText, gui = "italic" },

        -- mini.tabline
        MiniTablineHidden { TabLine },
        MiniTablineFill { MiniTablineHidden },
        MiniTablineCurrent { TabLineSel },
        MiniTablineVisible { fg = MiniTablineHidden.fg, bg = MiniTablineHidden.bg, bold = true },
        MiniTablineModifiedCurrent { fg = MiniTablineCurrent.bg, bg = MiniTablineCurrent.fg, bold = true },
        MiniTablineModifiedHidden { fg = MiniTablineHidden.bg, bg = MiniTablineHidden.fg },
        MiniTablineModifiedVisible { fg = MiniTablineVisible.bg, bg = MiniTablineVisible.fg, bold = true },
    }
end)

-- then pass the extended spec to lush for application
lush(spec)
-- stylua: ignore end
