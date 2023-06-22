local opts = {
  netrw_winsize = -28,
  netrw_banner = 0,
  netrw_liststyle = 3,
  netrw_browse_split = 4,
  netrw_altv = 1
}

for key, value in pairs(opts) do
  vim.g[key] = value
end

local colors = {
  fg = '#E2E2E3',
  bg = '#282828',
  dark = '#1d1f21',
  mid = '#303030',
  dark_gray = '#212121',
  gray = '#595F6F',
  light_gray = '#7F8490',
  info = '#85D3F2',
  warning = '#E7C664',
  danger = '#FF6O77',
  success = '#A7DF78',
}

local colorscheme = {
  netrwTreeBar = { fg = colors.gray, bg = colors.bg },
  netrwDir = { fg = colors.info }
}

local function highlight(group, table)
  local fg = table.fg or 'None'
  local bg = table.bg or 'None'
  local gui = table.gui and table.gui or 'None'
  local ctermbg = table.ctermbg and table.ctermbg or 'None'

  vim.cmd('hi ' .. group .. ' guifg=' .. fg .. ' guibg=' .. bg .. ' gui=' .. gui .. ' ctermbg=' .. ctermbg)
end

for key, value in pairs(colorscheme) do
  highlight(key, value)
end
