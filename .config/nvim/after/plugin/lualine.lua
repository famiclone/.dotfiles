local setup = require("lualine").setup

setup {
  options = {
    icons_enabled = true,
    theme = "sonokai",
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_d = { 'buffers' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
  }
}
