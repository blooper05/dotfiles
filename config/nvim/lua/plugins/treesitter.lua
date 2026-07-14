return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
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
    },
    event = 'BufReadPost',
    branch = 'master',
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
