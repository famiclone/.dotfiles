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


vim.cmd("hi clear")
vim.cmd("syntax reset")
vim.cmd("colorscheme gruvbox")
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
    bg = colors.gray
  },
  NvimTreeNormal = { fg = colors.fg, bg = colors.bg },
  NvimTreeEndOfBuffer = { fg = colors.fg, bg = colors.bg },
  NvimTreeLineNr = { fg = colors.bg, bg = colors.bg },
  NvimTreeFolderName = { fg = colors.fg },
  NvimTreeOpenedFolderName = { fg = colors.info },
  NvimTreeRootFolder = { fg = colors.gray },
  netrwTreeBar = { fg = colors.gray, bg = colors.bg },
  StatusLineMode1 = { fg = colors.danger, bg = colors.bg, gui = "bold" },
  StatusLineMode2 = { fg = colors.info, bg = colors.bg, gui = "bold" },
  StatusLineMode3 = { fg = colors.warning, bg = colors.bg, gui = "bold"},
  StatusLineMode4 = { fg = colors.gray, bg = colors.bg, gui = "bold" },
  StatusLineGitBranch = { fg = colors.fg, bg = colors.gray },
  StatusLineArrow = { fg = colors.gray, bg = colors.bg },
  StatusLineFileName = { fg = colors.fg, bg = colors.bg },
}

for key, value in pairs(groups) do
  highlight(key, value)
end

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
