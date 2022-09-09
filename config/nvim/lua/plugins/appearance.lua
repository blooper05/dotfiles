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
    as = 'colorscheme',
    event = 'UIEnter',
  },

  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({})
    end,
    event = 'UIEnter',
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
    after = 'colorscheme',
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
    after = 'colorscheme',
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
    after = { 'colorscheme', 'nvim-hlslens' },
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
        indent_blankline_use_treesitter       = true,
        indent_blankline_use_treesitter_scope = true,
        show_current_context                  = true,
        show_current_context_start            = true,
      })
    end,
    after = 'colorscheme',
  },

  {
    'jghauser/shade.nvim',
    config = function()
      require('shade').setup({})
    end,
    event = 'VimEnter',
  },

  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup({})
    end,
    event = 'VimEnter',
  },

  {
    'folke/zen-mode.nvim',
    requires = {
      { 'folke/twilight.nvim' },
    },
    config = function()
      require('zen-mode').setup({
        on_open  = function() vim.cmd([[silent lua require('shade').toggle()]]) end,
        on_close = function() vim.cmd([[silent lua require('shade').toggle()]]) end,
      })
    end,
    event = 'VimEnter',
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
    'rcarriga/nvim-notify',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('notify').setup({})
    end,
    event = 'VimEnter',
  },
}
