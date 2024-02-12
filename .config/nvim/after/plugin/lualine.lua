local lualine = require('lualine')

local function shortMode()
  return 
end

lualine.setup {
  options = {
    theme = 'auto',
    icons_enabled = true,
  },
  sections = {
    lualine_a = {shortMode},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'branch'},
    lualine_z = {''}
  },
}
