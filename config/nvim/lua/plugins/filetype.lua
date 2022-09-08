return {
  -- Natural Language

  {
    'koron/codic-vim', -- non-lua plugin
    config = function()
    end,
    event = 'VimEnter',
  },

  {
    'skanehira/translate.vim', -- non-lua plugin
    config = function()
    end,
    event = 'VimEnter',
  },

  -- CSV

  {
    'mechatroner/rainbow_csv', -- non-lua plugin
    config = function()
    end,
    ft = 'csv',
  },

  -- Jsonnet

  {
    'google/vim-jsonnet', -- non-lua plugin
    config = function()
    end,
    ft = 'jsonnet',
  },

  -- Markdown

  {
    'gaoDean/autolist.nvim',
    config = function()
      require('autolist').setup({})
    end,
    ft = 'markdown',
  },

  {
    'ellisonleao/glow.nvim',
    config = function()
      vim.keymap.set('n', '<Leader>p', function() vim.cmd('Glow') end, { silent = true })

      require('glow').setup({})
    end,
    ft = 'markdown',
  },

  -- PlantUML

  {
    'aklt/plantuml-syntax', -- non-lua plugin
    config = function()
    end,
    ft = 'plantuml',
  },
}
