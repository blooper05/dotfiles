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
    'b0o/incline.nvim',
    config = function()
      require('incline').setup({
        highlight = {
          groups = {
            InclineNormal = {
              default = true,
              group = 'CursorLine',
            },
            InclineNormalNC = {
              default = true,
              group = 'CursorLine',
            },
          },
        },
        render = function(props)
          local filepath = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(filepath, ':t')
          local devicons = require('nvim-web-devicons')
          local helpers = require('incline.helpers')
          local icon, color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified

          if not filename or filename == '' then
            filename = '[No Name]'
          end

          if not icon then
            icon = ''
          end

          if not color then
            color = helpers.contrast_color('#444c5e')
          end

          return {
            { ' ', icon, ' ', guifg = helpers.contrast_color(color), guibg = color },
            '  ',
            filename,
            ' ',
            modified and { '●', guifg = '#a3be8c' } or ' ',
            ' ',
          }
        end,
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
      })
    end,
    event = 'BufReadPost',
  },

  {
    'levouh/tint.nvim',
    opts = {
      highlight_ignore_patterns = { 'Telescope.*' },
      -- window_ignore_function = function(winid)
      --   local is_floating = vim.api.nvim_win_get_config(winid).relative ~= ''
      --   return is_floating
      -- end,
    },
    event = { 'WinNew', 'WinEnter', 'WinLeave' },
  },

  {
    'miversen33/sunglasses.nvim',
    config = true,
    event = 'WinNew',
    enabled = false, -- TODO:
  },

  {
    'nvim-zh/colorful-winsep.nvim',
    config = true,
    event = 'WinNew',
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
    'NvChad/nvim-colorizer.lua',
    init = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    config = true,
    cmd = 'ColorizerToggle',
  },
}
