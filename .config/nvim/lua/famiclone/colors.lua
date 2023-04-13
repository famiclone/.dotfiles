--require('rose-pine').setup({
--    disable_background = true
--})

local colors = {
  fg = '#ececec',
  bg = '#282828',
  dark = '#1d1f21',
  mid = '#303030',
  dark_gray = '#212121',
  gray = '#7b7b7b',
  light_gray = '#3c3836',
  info = '#83a598',
  warning = '#ff0000',
  danger = '#ff0000',
  success = '#07D01D',
}


vim.cmd("hi clear")
vim.cmd("syntax reset")
vim.cmd("colorscheme sonokai")
vim.o.background = "dark"

local function highlight(group, table)
  local fg = table.fg or 'None'
  local bg = table.bg or 'None'
  local gui = table.gui and table.gui or 'None'
  local ctermbg = table.ctermbg and table.ctermbg or 'None'

  vim.cmd('hi ' .. group .. ' guifg=' .. fg .. ' guibg=' .. bg .. ' gui=' .. gui .. ' ctermbg=' .. ctermbg)
end

local groups = {
  Normal = {
    bg = 'None',
    ctermbg = 'None'
  },
  EndOfBuffer = {
    bg = 'None',
    ctermbg = 'None'
  },
  GitSignsChange = {
    fg = colors.info,
  },
  NvimTreeNormal = { fg = colors.fg, bg = colors.bg },
  NvimTreeEndOfBuffer = { fg = colors.fg, bg = colors.bg },
  NvimTreeLineNr = { fg = colors.bg, bg = colors.bg },
}

for key, value in pairs(groups) do
  highlight(key, value)
end

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
