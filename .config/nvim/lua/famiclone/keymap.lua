local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

local nkeymaps = {
  ["<leader>e"] = { cmd = ":NvimTreeToggle<CR>", mode = 'n', opts = opts },
  ["<leader>r"] = { cmd = function() require('telescope.builtin').live_grep() end, mode = 'n', opts = opts },
  ["<leader>h"] = { cmd = function() require('telescope.builtin').help_tags() end, mode = 'n', opts = opts },
  -- Disable arrow keys
  ["<LEFT>"] = { cmd = "<NOP>", mode = 'n', opts = opts },
  ["<RIGHT>"] = { cmd = "<NOP>", mode = 'n', opts = opts },
  -- Buffers
  ["<UP>"] = { cmd = ":bnext<CR>", mode = 'n', opts = opts },
  ["<DOWN>"] = { cmd = ":bprevious<CR>", mode = 'n', opts = opts },
  ["<leader>b"] = { cmd = function() require('telescope.builtin').buffers() end, mode = 'n', opts = opts },
  -- Resize
  ["<C-K>"] = { cmd = ":resize -5<CR>", mode = 'n', opts = opts },
  ["<C-J>"] = { cmd = ":resize +5<CR>", mode = 'n', opts = opts },
  ["<C-H>"] = { cmd = ":vertical resize -5<CR>", mode = 'n', opts = opts },
  ["<C-L>"] = { cmd = ":vertical resize +5<CR>", mode = 'n', opts = opts },
  ["<esc><esc>"] = { cmd = ":noh<CR>", mode = 'n', opts = opts },
  ["C-d"] = { cmd = "<C-d>zz", mode = 'n', opts = opts },
  ["C-u"] = { cmd = "<C-u>zz", mode = 'n', opts = opts },
  -- LSP
  ["gd"] = { cmd = function() vim.lsp.buf.definition() end, mode = 'n', opts = opts },
  ["gr"] = { cmd = function() require("telescope.builtin").lsp_references() end, mode = 'n', opts = opts },
  ["K"] = { cmd = function() vim.lsp.buf.hover() end, mode = 'n', opts = opts },
  ["F"] = { cmd = function() vim.lsp.buf.format() end, mode = 'n', opts = opts },
  ["<leader>vrn"] = { cmd = function() vim.lsp.buf.rename() end, mode = 'n', opts = opts },
  ["<leader>vca"] = { cmd = function() vim.lsp.buf.code_action() end, mode = 'n', opts = opts },
}

local vkeymaps = {
  ["K"] = { cmd = ":m '<-2<CR>gv=gv", mode = 'v', opts = opts },
  ["J"] = { cmd = ":m '>+1<CR>gv=gv", mode = 'v', opts = opts },
}

for key, value in pairs(nkeymaps) do
  vim.keymap.set(value.mode, key, value.cmd, value.opts)
end

for key, value in pairs(vkeymaps) do
  vim.keymap.set(value.mode, key, value.cmd, value.opts)
end
