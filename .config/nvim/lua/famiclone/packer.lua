local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'hoob3rt/lualine.nvim'
  use 'github/copilot.vim'
  use 'lewis6991/gitsigns.nvim'
  use 'alvan/vim-closetag'
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use 'nvim-orgmode/orgmode'
  use 'dhruvasagar/vim-table-mode'
  --use 'nvim-tree/nvim-tree.lua'
  use 'ahmedkhalf/project.nvim'

  use 'sainnhe/sonokai'
  use 'catppuccin/nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }

  use {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
    end
  }

  use { 'akinsho/org-bullets.nvim', config = function()
    require('org-bullets').setup()
  end }

  use 'mattn/emmet-vim'

  --use {
  --  "zbirenbaum/copilot.lua",
  --  cmd = "Copilot",
  --  event = "InsertEnter",
  --}
  
  use 'simrat39/rust-tools.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
