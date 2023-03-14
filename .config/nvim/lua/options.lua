local options = {
  --colorcolumn = "80"
  incsearch = true,
  backup = false,
  cmdheight = 2,
  cursorline = true,
  completeopt = {"menu", "menuone", "noselect"},
  expandtab = true,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  number = true,
  numberwidth = 4,
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2,
  showtabline = 2,
  sidescrolloff = 8,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  wrap = true,
  writebackup = false,
  updatetime = 0,
  foldmethod = "syntax",
  list = true
}

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePost", { command = ":Prettier" })

vim.cmd("filetype plugin on")

for key, value in pairs(options) do
  vim.opt[key] = value
end

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

vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.cmd("command Bda bufdo bwipeout")
vim.cmd("set nofoldenable")



-- Dasht
vim.g.dasht_filetype_docsets = {
  ['elixir'] = {'erlang'},
  ['cpp'] = {'^c$', 'boost', 'OpenGL'},
  ['python'] = {'(num|sci)py', 'pandas'},
  ['html'] = {'css', 'js', 'bootstrap'}
}

-- create window below current one (default)
vim.g.dasht_results_window = 'new'

-- create window beside current one
vim.g.dasht_results_window = 'vnew'

-- use current window to show results
vim.g.dasht_results_window = 'enew'

-- create panel at left-most edge
vim.g.dasht_results_window = 'topleft vnew'

-- create panel at right-most edge
vim.g.dasht_results_window = 'botright vnew'

-- create new tab beside current one
vim.g.dasht_results_window = 'tabnew'
