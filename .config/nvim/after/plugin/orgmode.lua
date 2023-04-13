local orgmode = require("orgmode")
local setup = orgmode.setup
local path = "/Users/dentynok/Library/Mobile Documents/com~apple~CloudDocs/org"

orgmode.setup_ts_grammar()
setup({
  org_agenda_files = { path .. '/*.org' },
  org_default_notes_file = path .. '/refile.org',
  org_capture_templates = {
  r = {
      description = "Repo",
      template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
      target = path .. "/repos.org",
  }
}
})
