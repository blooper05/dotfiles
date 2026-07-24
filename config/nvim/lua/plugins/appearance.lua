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
      sections = {
        lualine_c = { { 'filename', path = 1 } },
        lualine_y = { { 'selectioncount', icon = '‹›' }, 'progress' },
      },
      extensions = { 'lazy', 'man', 'mason', 'nvim-dap-ui', 'nvim-tree', 'oil', 'quickfix', 'toggleterm', 'trouble' },
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
    'shellRaining/hlchunk.nvim',
    dependencies = {
      { 'EdenEast/nightfox.nvim' },
    },
    init = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    opts = {
      indent = {
        enable = true,
      },
    },
    event = 'UIEnter',
  },

  {
    'gen740/SmoothCursor.nvim',
    config = true,
    event = 'BufReadPost',
  },

  {
    'karb94/neoscroll.nvim',
    config = true,
    event = 'BufReadPost',
  },

  {
    'lewis6991/satellite.nvim',
    dependencies = {
      { 'lewis6991/gitsigns.nvim' },
    },
    config = true,
    event = 'BufReadPost',
  },

  {
    'folke/noice.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
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
    opts = {
      render = 'wrapped-compact',
    },
    config = function(_, opts)
      -- Use as the default notify function.
      vim.notify = require('notify').setup(opts)
    end,
    keys = {
      -- stylua: ignore start
      { '[telescope]n', function() require('telescope').extensions.notify.notify() end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'nvim-zh/colorful-winsep.nvim',
    config = true,
    event = 'WinLeave',
  },

  {
    'TaDaa/vimade',
    config = true,
    event = 'WinLeave',
  },
}
