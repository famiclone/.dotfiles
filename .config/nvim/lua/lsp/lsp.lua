local lspconfig = require("lspconfig")
local opts = {silent = true, noremap = true}

vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
vim.keymap.set("n", "<leader>gd", ":lua vim.lsp.buf.diagnostic()<CR>", opts)

function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }, _config or {})
end

lspconfig.tsserver.setup(config({
  on_attach = function(client)
    local ts_utils = require("nvim-lsp-ts-utils")

    ts_utils.setup({})
    ts_utils.setup_client(client)
  end,

  cmd = { vim.fn.stdpath("data") .. "/lsp_servers/tsserver/node_modules/.bin/typescript-language-server", "--stdio" },
  filetypes = { "javascript", "typescript", "javascript.jsx", "typescriptreact", "javascriptreact", "typescript.tsx" },
  root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", ".git")
  }
))

lspconfig.clangd.setup{}

lspconfig.bashls.setup{}

lspconfig.cssls.setup(config())

lspconfig.pyright.setup(config())

lspconfig.rust_analyzer.setup(config({
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  --[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}))
