return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local ok, lualine = pcall(require, 'lualine')
        if not ok then
            return
        end

        lualine.setup({
            options = {
                icons_enabled = false,
                theme = 'auto',
                section_separators = '',
                component_separators = '|'
            },
            sections = {
                lualine_c = { 'filename', 'filesize' }
            },
            tabline = {
                lualine_a = {
                    {
                        'tabs',
                        tab_max_length = 40,
                        mode = 2,
                        show_modified_status = false,
                        fmt = function(name, context)
                            -- Show [+] if buffer is modified in tab
                            local buflist = vim.fn.tabpagebuflist(context.tabnr)
                            local winnr = vim.fn.tabpagewinnr(context.tabnr)
                            local bufnr = buflist[winnr]
                            local mod = vim.fn.getbufvar(bufnr, '&mod')

                            return name .. (mod == 1 and ' [+]' or '')
                        end
                    }
                },
            },
        })
    end
}
