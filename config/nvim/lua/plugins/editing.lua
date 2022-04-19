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
    'monaqa/dial.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-a>',  require('dial.map').inc_normal(),  { noremap = true })
      vim.api.nvim_set_keymap('n', '<C-x>',  require('dial.map').dec_normal(),  { noremap = true })
      vim.api.nvim_set_keymap('v', '<C-a>',  require('dial.map').inc_visual(),  { noremap = true })
      vim.api.nvim_set_keymap('v', '<C-x>',  require('dial.map').dec_visual(),  { noremap = true })
      vim.api.nvim_set_keymap('v', 'g<C-a>', require('dial.map').inc_gvisual(), { noremap = true })
      vim.api.nvim_set_keymap('v', 'g<C-x>', require('dial.map').dec_gvisual(), { noremap = true })

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
  },

  {
    'junegunn/vim-easy-align', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('x', '<Enter>', '<Plug>(EasyAlign)', { silent = true })
    end,
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
      }
    end,
  },

  {
    'mbbill/undotree', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '<Space>U', ':<C-u>UndotreeToggle<CR>', { noremap = true, silent = true })
    end,
  },

  {
    'lambdalisue/suda.vim', -- non-lua plugin
    config = function()
      -- Automatically switch a buffer name when the target file is not readable or writable.
      vim.g.suda_smart_edit = true
    end,
  },

  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({})
    end,
  },
}
