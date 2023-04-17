local telescope = require('telescope')
local setup = telescope.setup

telescope.load_extension('projects')

setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 },
    },
  },
  pickers = {
  },
})

