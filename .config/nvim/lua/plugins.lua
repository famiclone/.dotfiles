local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup(
  function()
    use("wbthomason/packer.nvim")
    use("hoob3rt/lualine.nvim")
    use("ellisonleao/gruvbox.nvim")
    use("github/copilot.vim")
    use ("lewis6991/gitsigns.nvim")
    use("hrsh7th/cmp-buffer")
    use("morhetz/gruvbox")
    use("lukas-reineke/indent-blankline.nvim")
    use("neovim/nvim-lspconfig")                           -- Collection of configurations for built-in LSP client
    use("hrsh7th/nvim-cmp")                                -- Autocompetion plugin
    use("hrsh7th/cmp-nvim-lsp")                            -- LSP source for nvim-cmp
    use("saadparwaiz1/cmp_luasnip")                        -- Snippets source for nvim-cmp
    use("L3MON4D3/LuaSnip")                                -- Snippets plugin
    use("williamboman/nvim-lsp-installer")                 -- LSP server installer
    use("sunaku/vim-dasht")                                -- Dasht integration

    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("nvim-lsp-installer").setup()

    require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = true,
      space_char_blankline = " ",
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {

      },
      mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-c>"] = cmp.mapping.complete(),
        ["<S-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),

      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },
    })

    use("alvan/vim-closetag")
    use("prettier/vim-prettier")

    use("junegunn/fzf")
    use("junegunn/fzf.vim")

		use("mattn/emmet-vim")
    use("tpope/vim-fugitive")

    use("nvim-treesitter/nvim-treesitter")
		use("SmiteshP/nvim-gps", { requires = { "nvim-treesitter" }})

    local gps = require("nvim-gps")
    gps.setup()

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "gruvbox",
      },
      sections = {
        lualine_c = {
         {gps.get_location, cond = gps.is_available},
        }
      }
    }

    require("gitsigns").setup({
      signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '-', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
      signcolumn = true
    })

    require("lsp.lsp")

    if packer_bootstrap then
      require('packer').sync()
    end
  end
)
