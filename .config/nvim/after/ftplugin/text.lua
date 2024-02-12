vim.lsp.start({
    name = "LSP From Scratch",
    cmd = { 'npx', 'ts-node', vim.fn.expand('~/Projects/famiclone/lsp/server/src/server.ts') },
    capabilities = vim.lsp.protocol.make_client_capabilities()
    root_dir = vim.fs.dirname(
        vim.fs.find({'index.md'})
    )
})
