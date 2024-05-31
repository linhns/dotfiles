local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "AndreM222/copilot-lualine",
    },
}

local diagnostics = {
    "diagnostics",
    symbols = {
        error = " ",
        warn = " ",
        info = " ",
    },
}

local fileformat = {
    "fileformat",
    icons_enabled = true,
    symbols = {
        unix = "LF",
        dos = "CRLF",
        windows = "CR",
    },
}

local filetype = {
    "filetype",
    icon_only = true,
    icon = {
        align = "right",
    },
    padding = { left = 1, right = 0 },
}

local filename = {
    "filename",
    padding = { left = 0, right = 1 },
}

local lsp = {
    function()
        local msg = ""
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = " ",
}

M.config = function()
    local lualine = require("lualine")
    lualine.setup({
        options = {
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
        },
        sections = {
            lualine_b = { "branch", "diff" },
            lualine_c = { filetype, filename, diagnostics },
            lualine_x = { lsp, "copilot", "encoding" },
            lualine_y = { fileformat, "progress" },
        },
    })
end

return M
