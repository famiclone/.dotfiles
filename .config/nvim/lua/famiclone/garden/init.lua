local path = "$HOME/Library/Mobile Documents/com~apple~CloudDocs/garden"

local function save_folds()
  vim.cmd([[
    augroup remember_folds
    autocmd!
    "create the fold directory if it doesn't exists
    autocmd BufWinEnter *.md if !isdirectory(expand('%:p:h') . "/.fold") | call mkdir(expand('%:p:h') . "/.fold") | endif
    "save folds in .fold directory on BufWinLeave
    autocmd BufWinLeave *.md execute "mkview! " . expand('<afile>:p:h') . "/.fold/." . expand('<afile>:t') . ".view"
    "load folds from .fold directory on BufWinEnter
    autocmd BufWinEnter *.md execute "silent! source " . expand('%:p:h') . "/.fold/." . expand('%:t') . ".view"
    augroup END
  ]])
end

local function garden_enable()
  vim.fn.chdir(path)
  print("Working directory changed to " .. path)
  vim.cmd("e " .. path .. "/index.md")
  vim.opt.foldmethod = "manual"
  save_folds()
  vim.cmd([[
  function! s:MDGoToSection()
    let raw_filename = expand('<cfile>')
    let arg = substitute(raw_filename, '\([^#]*\)\(#\{1,6\}\)\([^#]*\)', '+\/\2\\\\s\3 \1', 'g')
    execute "edit" arg
  endfunction

  nnoremap <buffer> <key> :call <SID>MDGoToSection()<CR>
  ]])
end

vim.api.nvim_create_user_command(
  "GDEnable", function() garden_enable() end, {}
)

vim.api.nvim_create_user_command(
  "GDDisable",
  function()

  end, {}
)

vim.api.nvim_set_keymap("n", "<leader>g", ":GDEnable<CR>", { noremap = true, silent = true })
