local setup = require("clangd.lsp").setup()

setup.capabilities = vim.tbl_deep_extend("keep", setup.capabilities or {}, {
    textDocument = {
        completion = {
            completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                preselectSupport = true,
            },
        },
    },
})
