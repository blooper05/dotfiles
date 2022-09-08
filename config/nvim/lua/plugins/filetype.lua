return {
  -- Natural Language

  {
    'koron/codic-vim', -- non-lua plugin
    config = function()
    end,
    event = 'VimEnter',
  },

  {
    'uga-rosa/translate.nvim',
    config = function()
      require('translate').setup({})
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

  -- PlantUML

  {
    'aklt/plantuml-syntax', -- non-lua plugin
    config = function()
    end,
    ft = 'plantuml',
  },
}
