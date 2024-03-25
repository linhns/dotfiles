local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        import = "linhns.plugins",
    },
    {
        import = "linhns.plugins.lsp",
    },
    {
        import = "linhns.plugins.dap",
    },
    {
        import = "linhns.plugins.testing",
    },
}, {
    install = {
        colorscheme = { "tokyonight" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false, -- I find the config changed notification super annoying
    },
})
