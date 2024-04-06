--local M = {}
--
--local intro = {
--	"NVIM ${VERSION}",
--	"Nvim is open source and freely distributable",
--	"https://neovim.io/#chat",
--	"type	:help nvim<Enter>	if you are new!",
--	"type	:checkhealth<Enter>	to optimize Nvim",
--	"type	:help<Enter>		for help",
--}
--
--local name = "custom_intro"
--
--local autocmd_group = vim.api.nvim_create_augroup(name, {})
--
--vim.api.nvim_create_autocmd("VimEnter", {
--	group = autocmd_group,
--	callback = function()
--		local win = vim.api.nvim_get_current_win()
--		
--		local buf = vim.api.nvim_create_buf(true, true)
--		vim.api.nvim_buf_set_name(buf, name)
--		vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
--		vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
--		vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
--		vim.api.nvim_win_set_buf(win, buf)
--
--		vim.opt_local.list = false
--		vim.opt_local.number = false
--
--		vim.api.nvim_buf_set_lines(buf, 1, 1, true, intro)
--	end,
--	once = true,
--})

require("famiclone")

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  html = { filetypes = { 'html' } },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

vim.cmd([[
autocmd VimEnter * if argc() == 0 | echo "Welcome to Vim!" | endif
]])
