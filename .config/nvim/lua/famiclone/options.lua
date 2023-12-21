local options = {
  incsearch = true,
  tabstop = 2,
  shiftwidth = 2,
  swapfile = false,
  backup = false,
  cmdheight = 1,
  cursorline = true,
  expandtab = true,
  mouse = "a",
  number = true,
  numberwidth = 4,
  relativenumber = true,
  scrolloff = 8,
  showtabline = 1,
  sidescrolloff = 8,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  wrap = true,
  writebackup = false,
  updatetime = 0,
  foldmethod = "syntax",
  list = true,
  termguicolors = true,
  clipboard = 'unnamedplus',
  breakindent = true,
  undofile = true,
  ignorecase = true,
  timeoutlen = 300,
  completeopt = 'menuone,noselect'
}

for key, value in pairs(options) do
  vim.o[key] = value
end

vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.cmd("set nofoldenable")
vim.wo.signcolumn = 'yes'

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
