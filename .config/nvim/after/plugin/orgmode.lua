local orgmode = require("orgmode")
local setup = orgmode.setup

orgmode.setup_ts_grammar()
setup({
  org_agenda_files = {'~/my-orgs/**/*'},
  org_default_notes_file = '~/my-orgs/refile.org',
})
