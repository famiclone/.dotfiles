local orgmode = require("orgmode")
local setup = orgmode.setup
local path = "$HOME/Library/Mobile Documents/com~apple~CloudDocs/org"

orgmode.setup_ts_grammar()
setup({
  org_agenda_files = {path .. '/**/*'},
  org_default_notes_file = path .. '/refile.org',
})
