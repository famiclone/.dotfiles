vim.cmd([[
autocmd VimEnter * if argc() == 0 | echo "Hello, World!" | endif
]])
