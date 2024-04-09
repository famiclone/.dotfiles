local lspconfig = require('lspconfig')


lspconfig.lua_ls.setup {
  on_init = function(client)
    print('Language Server Protocol started!')
  end,

  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
        special = {
          ["import"] ='require',
        }
      },
      workspace = {
        library = {
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
        },
      },
    },
  },
}

