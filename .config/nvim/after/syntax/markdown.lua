vim.cmd([[
syntax match JournalDone /^×.*/
syntax match JournalTitle /\[\c\w\+\s\+\d\{4}\]/
syntax match JournalCalendarHeader /Mo.*Fr/
syntax match JournalCalendarHeaderWeekend / Sa.*Su/
syntax match JournalTodo /^·.*/
syntax match JournalWeekHeader /^WEEK\s\+\d\{1}\s\-.*/
syntax match JournalMoved /^>.*/
syntax match JournalNote /^-.*/
syntax match JournalEvent /^o.*/
syntax match GardenMetadataTag /\v(^|\s)\zs#\w.*/
syntax match GardenMetadataTitle /^-title.*/
hi! link JournalDone Comment
hi! link JournalTodo Normal
hi! link JournalCalendarHeaderWeekend Keyword
hi! link JournalCalendarHeader Normal
hi! link JournalWeekHeader Folded
hi! link JournalTitle Type
hi! link JournalMoved Keyword
hi link JournalNote Type
hi! link JournalEvent TabLineSel
hi! link markdownH1 Type
hi! link markdownH1Delimiter Type
hi! link markdownH2 Type
hi! link markdownH2Delimiter markdownH1Delimiter
hi! link markdownH3Delimiter markdownH1Delimiter
hi! link markdownH4Delimiter markdownH1Delimiter
hi! link markdownH5Delimiter markdownH1Delimiter
hi! link markdownH6Delimiter markdownH1Delimiter
hi! link GardenMetadataTag Underlined
hi! link GardenMetadataTitle Comment

syntax match gardenLink /<http.*>/
hi! link gardenLink Underlined

syntax match gardenMetadata /---\_.\{-}---/
hi! link gardenMetadata Comment
]])
