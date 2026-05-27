vim.diagnostic.config({
    severity_sort = true,
    virtual_text = {
        prefix = "",
        spacing = 2,
        format = function(diagnostic)
            local severity = vim.diagnostic.severity[diagnostic.severity]
            local msg = vim.split(diagnostic.message, "\n")[1]
            return string.format("%s: %s", string.sub(severity, 1, 1), msg)
        end,
    },
    float = {
        source = "if_many",
        prefix = function(diagnostic)
            local severity = vim.diagnostic.severity[diagnostic.severity]
            local prefix = string.format("%s: ", string.sub(severity, 1, 1))
            return prefix, "Diagnostic" .. severity:gsub("^%l", string.upper)
        end,
    },
    signs = false,
})
