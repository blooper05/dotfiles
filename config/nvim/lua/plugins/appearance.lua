return {
  {
    'EdenEast/nightfox.nvim', as = 'colorscheme',
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
    after = 'colorscheme',
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup({})
    end,
    after = 'colorscheme',
  },

  {
    'levouh/tint.nvim',
    config = function()
      require('tint').setup({})
    end,
    after = 'colorscheme',
  },

  {
    'rcarriga/nvim-notify',
    requires = {
      { 'nvim-telescope/telescope.nvim', opt = true },
    },
    setup = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = function()
      local function telescopeNotify()
        local success, telescope = pcall(require, 'telescope')

        if success then telescope.extensions.notify.notify() end
      end

      vim.keymap.set('n', '[telescope]n', telescopeNotify, { silent = true })

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
    'folke/zen-mode.nvim',
    requires = {
      { 'folke/twilight.nvim', opt = true, cmd = 'ZenMode' }
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
