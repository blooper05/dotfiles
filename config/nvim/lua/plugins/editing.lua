return {
  {
    'numToStr/Comment.nvim',
    dependencies = {
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    keys = {
      { 'gc', mode = { 'n', 'x' } },
      { 'gb', mode = { 'n', 'x' } },
    },
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
  },

  {
    'Wansmer/treesj',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      -- stylua: ignore start
      { 'gJ', function() require('treesj').join()  end, mode = 'n', silent = true },
      { 'gS', function() require('treesj').split() end, mode = 'n', silent = true },
      -- stylua: ignore end
    },
  },

  {
    'junegunn/vim-easy-align', -- non-lua plugin
    cmd = { 'EasyAlign', 'LiveEasyAlign' },
    keys = {
      -- stylua: ignore start
      { 'ga', '<Plug>(EasyAlign)',     mode = { 'n', 'x' }, remap = true, silent = true },
      { 'gA', '<Plug>(LiveEasyAlign)', mode = { 'n', 'x' }, remap = true, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'kaplanz/retrail.nvim',
    opts = {
      hlgroup = 'Substitute',
    },
    event = 'BufReadPost',
  },

  {
    'chrisgrieser/nvim-origami',
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
    config = true,
    event = 'BufReadPost',
  },

  {
    'monaqa/dial.nvim',
    config = function()
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
          augend.case.new({
            types = { 'camelCase', 'snake_case', 'kebab-case', 'PascalCase', 'SCREAMING_SNAKE_CASE' },
            cyclic = true,
          }),
          augend.constant.new({
            elements = {
              'pick',
              'fixup',
              'reword',
              'edit',
              'squash',
              'exec',
              'break',
              'drop',
              'label',
              'reset',
              'merge',
            },
            word = true,
            cyclic = true,
          }),
        },
      })
    end,
    cmd = { 'DialIncrement', 'DialDecrement' },
    keys = {
      -- stylua: ignore start
      { '<C-a>',  '<Plug>(dial-increment)',  mode = { 'n', 'v' } },
      { '<C-x>',  '<Plug>(dial-decrement)',  mode = { 'n', 'v' } },
      { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' } },
      { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' } },
      -- stylua: ignore end
    },
  },

  {
    'folke/todo-comments.nvim',
    dependencies = {
      { 'folke/trouble.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = true,
    event = 'BufReadPost',
    keys = {
      -- stylua: ignore start
      { '[lsp]t',       function() vim.cmd('TodoTrouble') end,   silent = true },
      { '[telescope]t', function() vim.cmd('TodoTelescope') end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'debugloop/telescope-undo.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('telescope').load_extension('undo')
    end,
    keys = {
      -- stylua: ignore start
      { '[telescope]U', function() require('telescope').extensions.undo.undo() end, silent = true },
      -- stylua: ignore end
    },
  },
}
