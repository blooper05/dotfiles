return {
  {
    'numToStr/Comment.nvim',
    requires = {
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    config = function()
      require('Comment').setup({})
    end,
    event = 'VimEnter',
  },

  {
    'folke/todo-comments.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim'                       },
      { 'folke/trouble.nvim',              opt = true },
      { 'nvim-telescope/telescope.nvim',   opt = true },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    config = function()
      vim.keymap.set('n', '[lsp]t',       function() vim.cmd('TodoTrouble')   end, { silent = true })
      vim.keymap.set('n', '[telescope]t', function() vim.cmd('TodoTelescope') end, { silent = true })

      require('todo-comments').setup({})
    end,
    after = { 'trouble.nvim', 'telescope.nvim' },
  },

  {
    'monaqa/dial.nvim',
    config = function()
      local map = require('dial.map')

      vim.keymap.set('n', '<C-a>',  map.inc_normal(),  {})
      vim.keymap.set('n', '<C-x>',  map.dec_normal(),  {})
      vim.keymap.set('v', '<C-a>',  map.inc_visual(),  {})
      vim.keymap.set('v', '<C-x>',  map.dec_visual(),  {})
      vim.keymap.set('v', 'g<C-a>', map.inc_gvisual(), {})
      vim.keymap.set('v', 'g<C-x>', map.dec_gvisual(), {})

      local augend = require('dial.augend')

      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.date.alias['%Y-%m-%d'],
          augend.date.alias['%m/%d'],
          augend.date.alias['%H:%M'],
          augend.constant.alias.ja_weekday_full,
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({
            elements = { 'pick', 'fixup', 'reword', 'edit', 'squash', 'exec', 'break', 'drop', 'label', 'reset', 'merge' },
            word     = true,
            cyclic   = true,
          }),
        },
      })
    end,
    event = 'VimEnter',
  },

  {
    'junegunn/vim-easy-align', -- non-lua plugin
    config = function()
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { remap = true, silent = true })
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { remap = true, silent = true })
    end,
    event = 'VimEnter',
  },

  {
    'ntpeters/vim-better-whitespace', -- non-lua plugin
    config = function()
      -- Strip whitespaces when I save files.
      vim.g.strip_whitespace_on_save = true
      vim.g.strip_whitespace_confirm = false

      vim.g.better_whitespace_filetypes_blacklist = {
        'diff',
        'git',
        'gitcommit',
        'help',
        'markdown',
        'packer',
        'toggleterm',
      }
    end,
    event = 'VimEnter',
  },

  {
    'mbbill/undotree', -- non-lua plugin
    config = function()
      vim.keymap.set('n', '<Space>U', function() vim.cmd('UndotreeToggle') end, { silent = true })

      vim.g.undotree_WindowLayout       = 2
      vim.g.undotree_SetFocusWhenToggle = true
      vim.g.undotree_ShortIndicators    = true
    end,
    event = 'VimEnter',
  },

  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({})
    end,
    event = 'VimEnter',
  },
}
