local lualine = require('lualine')

local function shortMode()
  return string.upper(vim.api.nvim_get_mode().mode)
end

lualine.setup {
  options = {
    theme = 'auto',
    icons_enabled = true,
  },
  sections = {
    lualine_a = {shortMode},
    lualine_b = {
      'diagnostics',

      sources = {'nvim_lsp', 'nvim_diagnostic'},
      sections = {'error', 'warn', 'info', 'hint'},
      symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
      colored = true,           -- Displays diagnostics status in color if set to true.
      update_in_insert = false, -- Update diagnostics in insert mode.
      always_visible = false,
    },
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'branch'},
    lualine_z = {''}
  },
}
