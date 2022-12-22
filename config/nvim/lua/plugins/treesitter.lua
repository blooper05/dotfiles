return {
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        indent = {
          enable = false,
        },
      })
    end,
    event = 'BufReadPost',
  },

  {
    'yioneko/nvim-yati',
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        yati = { enable = true },
      })
    end,
    after = 'nvim-treesitter',
  },

  {
    'm-demare/hlargs.nvim',
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('hlargs').setup({})
    end,
    after = 'nvim-treesitter',
  },
}
