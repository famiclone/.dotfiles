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


vim.cmd([[
autocmd BufEnter term://* startinsert
autocmd BufWinLeave term://* call CloseTerminalOnExit()
function! CloseTerminalOnExit()
    if &buftype ==# 'terminal' && v:term_job_id !=# -1
        let job_id = v:term_job_id
        call timer_start(100, {-> Check_job_status(job_id)})
    endif
endfunction
function! Check_job_status(job_id)
    let job_status = job_info(a:job_id)['status']
    if job_status !=# 'run'
        call timer_stopall()
        q
    endif
endfunction
]])
