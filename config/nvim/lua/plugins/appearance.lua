return {
  {
    'EdenEast/nightfox.nvim',
    as = 'colorscheme',
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
    'nvim-tree/nvim-web-devicons',
    config = function() end,
    module = 'nvim-web-devicons',
  },

  {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'SmiteshP/nvim-navic', opt = true },
      { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    setup = function()
      -- Get rid of redundant mode display.
      vim.opt.showmode = false
    end,
    config = function()
      local navic = require('nvim-navic')

      require('lualine').setup({
        options = {
          globalstatus = true,
        },
        extensions = {
          'man',
          'nvim-dap-ui',
          'nvim-tree',
          'quickfix',
          'toggleterm',
        },
        sections = {
          lualine_c = {
            { navic.get_location, cond = navic.is_available },
          },
        },
      })
    end,
    wants = 'nvim-navic',
    after = 'colorscheme',
  },

  {
    'akinsho/bufferline.nvim',
    requires = {
      { 'nvim-tree/nvim-web-devicons', opt = true },
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
        indent_blankline_use_treesitter = true,
        indent_blankline_use_treesitter_scope = true,
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
    event = 'BufReadPost',
  },

  {
    'petertriho/nvim-scrollbar',
    requires = {
      { 'kevinhwang91/nvim-hlslens', opt = true },
      { 'lewis6991/gitsigns.nvim', opt = true },
    },
    config = function()
      require('scrollbar').setup({
        handlers = {
          gitsigns = true,
          search = true,
        },
      })
    end,
    wants = { 'nvim-hlslens', 'gitsigns.nvim' },
    event = 'BufReadPost',
  },

  {
    'folke/noice.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
      { 'rcarriga/nvim-notify', opt = true },
    },
    setup = function()
      -- Redraw during macro execution.
      vim.opt.lazyredraw = false

      -- Hide the command-line.
      vim.opt.cmdheight = 0
    end,
    config = function()
      require('noice').setup({
        messages = {
          view_search = false,
        },
        popupmenu = {
          backend = 'cmp',
        },
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        presets = {
          command_palette = true,
          long_message_to_split = true,
        },
      })
    end,
    event = { 'BufNewFile', 'BufReadPost', 'InsertEnter', 'CmdlineEnter' },
  },

  {
    'rcarriga/nvim-notify',
    requires = {
      { 'nvim-telescope/telescope.nvim', opt = true },
    },
    setup = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      vim.keymap.set('n', '[telescope]n', function()
        require('telescope').extensions.notify.notify()
      end, { silent = true })
    end,
    config = function()
      -- Use as the default notify function.
      vim.notify = require('notify')
    end,
    module = 'notify',
  },

  {
    'levouh/tint.nvim',
    config = function()
      require('tint').setup({})
    end,
    event = { 'WinEnter', 'WinLeave' },
  },

  {
    'folke/zen-mode.nvim',
    requires = {
      { 'folke/twilight.nvim', opt = true },
    },
    config = function()
      require('zen-mode').setup({})
    end,
    wants = 'twilight.nvim',
    cmd = 'ZenMode',
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
