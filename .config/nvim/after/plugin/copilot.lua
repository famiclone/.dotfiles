vim.g.copilot_filetypes = {
    ["*"] = false,
    ["javascript"] = true,
    ["javacriptreact"] = true,
    ["typescriptreact"] = true,
    ["bash"] = true,
    ["typescript"] = true,
    ["lua"] = false,
    ["rust"] = true,
    ["c"] = true,
    ["c#"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["python"] = true,
  }

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Previous("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next("<CR>")', { silent = true, expr = true })
