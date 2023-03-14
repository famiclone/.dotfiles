" Vim syntax file
" Language: VHTTP
" Maintainer: Denys Tynok
" Latest Revision: 27 July 2022

if exists("b:current_syntax")
  finish
endif

syntax keyword vHttpMethodGet GET nextgroup=vHttpUrl skipwhite
syntax keyword vHttpMethodPost POST nextgroup=vHttpUrl skipwhite
syntax keyword vHttpMethodDelete DELETE nextgroup=vHttpUrl skipwhite
syntax keyword vHttpMethodPut PUT nextgroup=vHttpUrl skipwhite

syntax match vHttpComment /--\s*.*$/ skipwhite
syntax match vHttpUrl "http.*\s" skipwhite
syntax match vHttpBodyKey /\s*.*:/ skipwhite
syntax region vHttpBody start="{" end="}" fold contains=vHttpBodyKey
syntax match vHttpGroup /<<\s*.*/ skipwhite
syntax match vHttpGroup />>/ skipwhite



hi vHttpMethodGet term=bold guibg=yellowgreen guifg=black
hi vHttpMethodPost term=bold guibg=blue
hi vHttpMethodPut term=bold guibg=skyblue guifg=black
hi vHttpMethodDelete term=bold guibg=tomato
hi vHttpUrl term=underline gui=underline
r
hi vHttpComment guifg=gray 

hi vHttpBody guifg=gray 
hi vHttpGroup term=bold guifg=skyblue

