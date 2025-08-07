return {
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtml" },
    settings = {
        gopls = {
            codelenses = {
                test = true,
            },
            analyses = {
                unusedvariable = true,
            },
            gofumpt = true,
            usePlaceholders = true,
            templateExtensions = { "gotmpl", "gohtml", "tmpl" },
            semanticTokens = true,
        },
    },
}
