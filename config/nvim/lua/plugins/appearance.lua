return {
  {
    'EdenEast/nightfox.nvim',
    config = function()
      -- Assume a dark background.
      vim.opt.background = 'dark'

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      -- Use nordfox as colorscheme.
      vim.cmd('colorscheme nordfox')
    end,
  },

  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({})
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Get rid of redundant mode display.
      vim.opt.showmode = false

      require('lualine').setup({
        options = {
          globalstatus = true,
        },
      })
    end,
  },

  {
    'akinsho/bufferline.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('bufferline').setup({
        options = {
          mode = 'tabs',
        },
      })
    end,
  },

  {
    'petertriho/nvim-scrollbar',
    requires = {
      { 'kevinhwang91/nvim-hlslens', opt = true },
    },
    config = function()
      require('scrollbar').setup({
        handlers = {
          search = true,
        },
      })
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    requires = {
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('indent_blankline').setup({
        indent_blankline_use_treesitter = true,
        show_current_context            = true,
        show_current_context_start      = true,
      })
    end,
  },

  {
    'sunjon/shade.nvim', disable = true,
    config = function()
      require('shade').setup({})
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('colorizer').setup({})
    end,
  },

  {
    'folke/zen-mode.nvim',
    requires = {
      { 'folke/twilight.nvim' },
    },
    config = function()
      require('zen-mode').setup({})
    end,
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({})
    end,
  },
}
