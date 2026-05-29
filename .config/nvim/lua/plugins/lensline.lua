local utils = require('utils')

local gr = utils.augroup('linhns/lensline', {})
utils.autocmd('LspAttach', {
    group = gr,
    callback = function()
        require('lensline').setup({
            profiles = {
                {
                    name = 'minimal',
                    style = {
                        placement = 'inline',
                        render = 'focused',
                    },
                },
            },
        })
    end,
})
