return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
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
          enable = true,
        },
      })
    end,
    event = 'BufReadPost',
  },

  {
    'm-demare/hlargs.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = true,
    event = 'BufReadPost',
  },
}
