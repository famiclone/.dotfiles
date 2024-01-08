vim.cmd[[
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

]]

vim.cmd[[nnoremap <F6> :call SynStack()<CR>]]

