local options = {
  incsearch = true,
  backup = false,
  cmdheight = 1,
  cursorline = true,
  completeopt = { "menu", "menuone", "noselect" },
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
  list = true,
  termguicolors = true,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.cmd("set nofoldenable")

