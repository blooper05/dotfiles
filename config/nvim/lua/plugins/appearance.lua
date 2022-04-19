local colorscheme = 'nightfox.nvim'

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
    after = colorscheme,
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
    after = colorscheme,
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
    after = colorscheme,
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
    event = 'VimEnter',
  },

  {
    'sunjon/shade.nvim',
    config = function()
      require('shade').setup({})
    end,
    event = 'VimEnter',
    disable = true,
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('colorizer').setup({})
    end,
    event = 'VimEnter',
  },

  {
    'folke/zen-mode.nvim',
    requires = {
      { 'folke/twilight.nvim', opt = true },
    },
    config = function()
      require('zen-mode').setup({})
    end,
    event = 'VimEnter',
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({})
    end,
    event = 'VimEnter',
  },
}
