return {
  {
    'EdenEast/nightfox.nvim',
    setup = function()
      -- Assume a dark background.
      vim.opt.background = 'dark'

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = function()
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
    'levouh/tint.nvim',
    config = function()
      require('tint').setup({})
    end,
    event = 'BufReadPre',
  },

  {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    setup = function()
      -- Get rid of redundant mode display.
      vim.opt.showmode = false
    end,
    config = function()
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
    setup = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = function()
      require('bufferline').setup({
        options = {
          mode = 'tabs',
        },
      })
    end,
    after = 'colorscheme',
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    requires = {
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    setup = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = function()
      require('indent_blankline').setup({
        indent_blankline_use_treesitter       = true,
        indent_blankline_use_treesitter_scope = true,
        show_current_context                  = true,
        show_current_context_start            = true,
      })
    end,
    event = 'BufReadPre',
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
    event = 'BufReadPre',
  },

  {
    'rcarriga/nvim-notify',
    requires = {
      { 'nvim-telescope/telescope.nvim', opt = true },
    },
    config = function()
      vim.keymap.set('n', '[telescope]n', require('telescope').extensions.notify.notify, { silent = true })

      require('telescope').load_extension('notify')

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      -- Use as the default notify function.
      vim.notify = require('notify')

      vim.notify.setup({
        max_width     = 80,
        minimum_width = 80,
      })
    end,
    event = 'BufWinEnter',
  },

  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup({})
    end,
    event = 'BufWinEnter',
  },

  {
    'folke/zen-mode.nvim',
    requires = {
      { 'folke/twilight.nvim', cmd = 'ZenMode' }
    },
    config = function()
      require('zen-mode').setup({})
    end,
    after = 'twilight.nvim',
  },

  {
    'norcalli/nvim-colorizer.lua',
    setup = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = function()
      require('colorizer').setup({})
    end,
    cmd = 'ColorizerToggle',
  },
}
