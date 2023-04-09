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

    require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "query", "http", "json"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { "c", "rust" },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
}

    use {
      "rest-nvim/rest.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("rest-nvim").setup({
          -- Open request results in a horizontal split
          result_split_horizontal = false,
          -- Keep the http file buffer above|left when split horizontal|vertical
          result_split_in_place = false,
          -- Skip SSL verification, useful for unknown certificates
          skip_ssl_verification = false,
          -- Encode URL before making request
          encode_url = true,
          -- Highlight request on run
          highlight = {
            enabled = true,
            timeout = 150,
          },
          result = {
            -- toggle showing URL, HTTP info, headers at top the of result window
            show_url = true,
            show_http_info = true,
            show_headers = true,
            -- executables or functions for formatting response body [optional]
            -- set them to false if you want to disable them
            formatters = {
              json = "jq",
              html = function(body)
                return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
              end
            },
          },
          -- Jump to request line on run
          jump_to_request = false,
          env_file = '.env',
          custom_dynamic_variables = {
            ["$date"] = function()
              local os_date = os.date('%Y-%m-%d')
              return os_date
            end,
            ["$week"] = function()
              local week = os.execute("date +%U")
              return week
            end
          },
          yank_dry_run = true,
        })
      end
}

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
