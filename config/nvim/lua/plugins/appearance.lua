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
    config = function()
      require('nvim-web-devicons').setup({})
    end,
    event = 'UIEnter',
  },

  {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'nvim-tree/nvim-web-devicons', opt = true },
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
        extensions = {
          'man',
          'nvim-dap-ui',
          'nvim-tree',
          'quickfix',
          'toggleterm',
        },
      })
    end,
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
    after = 'colorscheme',
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
    after = 'colorscheme',
    wants = { 'nvim-hlslens', 'gitsigns.nvim' },
  },

  {
    'levouh/tint.nvim',
    config = function()
      require('tint').setup({})
    end,
    after = 'colorscheme',
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
    end,
    config = function()
      local function telescopeNotify()
        local success, telescope = pcall(require, 'telescope')

        if success then
          telescope.extensions.notify.notify()
        end
      end

      vim.keymap.set('n', '[telescope]n', telescopeNotify, { silent = true })

      -- Use as the default notify function.
      vim.notify = require('notify')
    end,
    event = 'BufWinEnter',
  },

  {
    'folke/zen-mode.nvim',
    requires = {
      { 'folke/twilight.nvim', opt = true, cmd = 'ZenMode' },
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
