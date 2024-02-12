vim.lsp.start {
  name = "Garden LSP",
  cmd = { "npx", "ts-node", vim.fn.expand("~/.config/nvim/after/ftplugin/garden-lsp/server/src/index.ts") },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  root_dir = vim.fs.dirname(
    vim.fs.find("index.md", { upward = true })[1]
  )
}

local function create_toc()
  vim.cmd('silent vimgrep /# .*/j %')
  vim.cmd('vert 50 copen')
end

local function create_document(opts)
  local filename
  if string.len(opts.args) > 0 then
    filename = opts.args
  else
    filename = vim.fn.input('Enter a name: ')
  end

  local file = io.open(filename, 'w')
  file:write('# ' .. filename .. '\n')
  file:close()
  print('\nCreated ' .. filename)
end

local function format_foldtext()
  local line = vim.fn.getline(vim.v.foldstart)

  print(line)
end

vim.api.nvim_create_user_command('Toc', create_toc, {})
vim.api.nvim_create_user_command('Fo', format_foldtext, {})

vim.api.nvim_create_user_command('GardenDoc', create_document, { nargs = "?" })
vim.api.nvim_set_keymap('n', '<C-n>', ':GardenDoc<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd(
  { "BufEnter", "BufRead", "BufNewFile" },
  {
    group = vim.api.nvim_create_augroup('wikiLinkMatch', { clear = true }),
    pattern = { "*.md" },
    callback = function()
      vim.wo.conceallevel = 2
      vim.fn.matchadd('wikiLinkMatch', '\\[\\[\\zs.\\+\\ze\\]\\]', 10)
      vim.fn.matchadd('wikiLinkL', '\\zs\\[\\[\\ze.\\+\\]\\]', 0, -1, {
        conceal = ''
      })
      vim.fn.matchadd('wikiLinkR', '\\[\\[.\\+\\zs\\]\\]\\ze', 0, -1, {
        conceal = ''
      })
      vim.api.nvim_set_hl(0, 'wikiLinkMatch', { link = 'markdownUrl' })
      vim.api.nvim_set_hl(0, 'wikiLinkL', { link = 'Comment' })
      vim.api.nvim_set_hl(0, 'wikiLinkR', { link = 'Comment' })
    end
  }
)

local function go_to_def()
  local line = vim.fn.getline('.')
  local link = string.match(line, '%[%[(.*)%]%]')
  if link then
    vim.cmd('e ' .. link .. '.md')
  end
end

vim.keymap.set(
  'n', 'gd', go_to_def, { noremap = true, silent = true }
)
