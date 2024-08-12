require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		sh = { "shfmt" },
		go = { "gofumpt" },
	},
	format_on_save = {
		timeout_ms = 500,
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- Customize formatters
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
		},
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
