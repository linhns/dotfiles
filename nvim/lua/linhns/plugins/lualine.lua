local cfg = {
    options = {
        theme = "auto",
        section_separators = "",
        component_separators = "",
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }

}

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number | nil hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ''
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
        end
        return str
    end
end

-- Inserts a component to the front of a section, which displays on the left
local function ins_left(section, component)
    table.insert(cfg.sections[section], component)
end

-- Inserts a component to the back of a section, which displays on the right
local function ins_right(section, component)
    table.insert(cfg.sections[section], component)
end

ins_left("lualine_a",
    {
        "mode",
        fmt = function(str, _)
            return str:sub(1, 3)
        end
    }
)

ins_left("lualine_b",
    {
        "branch",
        fmt = trunc(100, 10, nil, true),
    }
)



return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local ok, lualine = pcall(require, "lualine")
        if not ok then
            return
        end

        lualine.setup(cfg)

        -- lualine.setup({
        --     options = {
        --         icons_enabled = true,
        --         theme = "auto",
        --         section_separators = '',
        --         component_separators = '|'
        --     },
        --     sections = {
        --         lualine_c = { "filename", "filesize" },
        --     },
        --     -- tabline = {
        --     --     lualine_a = {
        --     --         {
        --     --             'tabs',
        --     --             tab_max_length = 40,
        --     --             mode = 2,
        --     --             show_modified_status = false,
        --     --             fmt = function(name, context)
        --     --                 -- Show [+] if buffer is modified in tab
        --     --                 local buflist = vim.fn.tabpagebuflist(context.tabnr)
        --     --                 local winnr = vim.fn.tabpagewinnr(context.tabnr)
        --     --                 local bufnr = buflist[winnr]
        --     --                 local mod = vim.fn.getbufvar(bufnr, '&mod')
        --     --
        --     --                 return name .. (mod == 1 and ' [+]' or '')
        --     --             end
        --     --         }
        --     --     },
        --     -- },
        -- })
    end,
}
