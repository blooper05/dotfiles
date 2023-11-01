return {
  {
    'EdenEast/nightfox.nvim',
    init = function()
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
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'EdenEast/nightfox.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    init = function()
      -- Get rid of redundant mode display.
      vim.opt.showmode = false
    end,
    opts = {
      options = {
        globalstatus = true,
      },
      extensions = {
        'lazy',
        'man',
        'mason',
        'nvim-dap-ui',
        'nvim-tree',
        'quickfix',
        'toggleterm',
        'trouble',
      },
    },
    event = 'UIEnter',
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = {
      { 'EdenEast/nightfox.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    init = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    opts = {
      options = {
        mode = 'tabs',
      },
    },
    event = 'UIEnter',
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = {
      { 'EdenEast/nightfox.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    init = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    main = 'ibl',
    config = true,
    event = 'BufReadPost',
  },

  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      { 'kevinhwang91/nvim-hlslens' },
      { 'lewis6991/gitsigns.nvim' },
    },
    opts = {
      handlers = {
        gitsigns = true,
        search = true,
      },
    },
    event = 'BufReadPost',
  },

  {
    'folke/noice.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'rcarriga/nvim-notify' },
    },
    init = function()
      -- Redraw during macro execution.
      vim.opt.lazyredraw = false

      -- Hide the command-line.
      vim.opt.cmdheight = 0
    end,
    opts = {
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
    },
    event = { 'BufNewFile', 'BufReadPost', 'InsertEnter', 'CmdlineEnter' },
  },

  {
    'rcarriga/nvim-notify',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    init = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = function()
      -- Use as the default notify function.
      vim.notify = require('notify')
    end,
    keys = {
      -- stylua: ignore start
      { '[telescope]n', function() require('telescope').extensions.notify.notify() end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'levouh/tint.nvim',
    opts = {
      highlight_ignore_patterns = { 'Telescope.*' },
    },
    event = { 'WinEnter', 'WinLeave' },
  },

  {
    'folke/zen-mode.nvim',
    dependencies = {
      { 'folke/twilight.nvim' },
    },
    config = true,
    cmd = 'ZenMode',
  },

  {
    'norcalli/nvim-colorizer.lua',
    init = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = true,
    cmd = 'ColorizerToggle',
  },
}
