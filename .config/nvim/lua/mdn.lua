local api = vim.api

local open_split = function()
  local url = "https://developer.mozilla.org/en-US/docs/Web/API/" .. vim.cmd('echo expand("<cword>")')

  print(url)

  --vim.cmd("vnew | set filetype=md | read !curl " .. url)
  local win = api.nvim_get_current_win()
  local buffer = api.nvim_get_current_buf()

  api.nvim_win_set_buf(win, buffer)
  
end

--fetch

vim.api.nvim_create_user_command("MDN", function() open_split() end, {})
api.nvim_set_keymap("n", "<leader>m", ":MDN<CR>", {noremap = true, silent = true})
