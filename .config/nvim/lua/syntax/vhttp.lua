-- VHTTP Syntax highlight file

vim.cmd("setlocal suffixesadd+=.vhttp")
vim.cmd("syntax sync fromstart")
vim.cmd("syntax keyword vHttpMethod POST GET HEAD DELETE PUT") 
vim.cmd("hi vHttpMethod guibg=red")
