vim.g.mapleader = ' '
vim.g.mapleader_mode = 'n'

local opts = { noremap = true, silent = true }

--vim.keymap.set("n", "<leader>d", ':Dash <c-r>=expand("<cword>")<CR> javascript <CR>', opts) -- Get word under a cursor and search in Dash.app
--vim.keymap.set("n", "<leader>cm",   ":vsplit | :term ~/.scripts/git-commit-checkout<CR>", opts)


local keymaps = {
  ["<C-p>"] = { cmd = ":Files<CR>", mode = 'n', opts = opts},
  ["<leader>r"] = { cmd = ":Rg<CR>", mode = 'n', opts = opts},
  ["<leader>gf"] = { cmd = ":GFiles<CR>", mode = 'n', opts = opts},
  
  -- Disable arrow keys
  ["<LEFT>"] = { cmd = "<NOP>", mode = 'n', opts = opts},
  ["<RIGHT>"] = { cmd = "<NOP>", mode = 'n', opts = opts},
  
  -- Buffers
  ["<UP>"] = { cmd = ":bnext<CR>", mode = 'n', opts = opts},
  ["<DOWN>"] = { cmd = ":bprevious<CR>", mode = 'n', opts = opts},
  ["<leader>b"] = { cmd = ":Buffers<CR>", mode = 'n', opts = opts},

  -- Resize
  ["<C-K>"] = { cmd = ":resize -5<CR>", mode = 'n', opts = opts},
  ["<C-J>"] = { cmd = ":resize +5<CR>", mode = 'n', opts = opts},
  ["<C-H>"] = { cmd = ":vertical resize -5<CR>", mode = 'n', opts = opts},
  ["<C-L>"] = { cmd = ":vertical resize +5<CR>", mode = 'n', opts = opts},

  -- File modifications
  ["<leader>x"] = { cmd = ":!chmod +x %<CR>", mode = 'n', opts = opts},

  -- Reload config
  ["<leader><CR>"] = { cmd = ":so ~/.config/nvim/init.lua<CR>", mode = 'n', opts = opts},

  -- netrw
  ["<leader>e"] = { cmd = ":Vex<CR>", mode = 'n', opts = opts},

  ["<esc><esc>"] = {cmd = ":noh<CR>", mode = 'n', opts=opts},


  -- Dasht
  -- Type mode:
  -- Search related docsets
  ["<leader>k"] = {cmd = ":Dasht <Space>", mode = 'n', opts=opts},
  -- Search all the docsets
  ["<leader><leader>k"] = {cmd = ":Dasht!", mode = 'n', opts=opts},

  -- Under cursor:
  -- Search related docsets
  ["leader>K"] = {cmd = ":call Dasht(dasht#cursor_search_terms())<CR>", mode = 'n', opts={silent = true}},
  -- Search all the docsets
  ["<leader><leader>K"] = {cmd = ":call Dasht(dasht#cursor_search_terms(), '!')<CR>", mode = 'n', opts={silent = true}},
}

for key, value in pairs(keymaps) do
  vim.keymap.set(value.mode, key, value.cmd, value.opts)
end

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Previous("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next("<CR>")', { silent = true, expr = true })

vim.keymap.set("n", "<leader>r", "<Plug>RestNvim<CR>", { silent = true, desc = "Rest" })
vim.keymap.set("n", "<leader>rp", "<Plug>RestNvimPreview<CR>", { silent = true, desc = "Rest preview" })
vim.keymap.set("n", "<leader>rl", "<Plug>RestNvimLast<CR>", { silent = true, desc = "Rest last" })
