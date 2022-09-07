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

  -- PlantUML

  {
    'aklt/plantuml-syntax', -- non-lua plugin
    config = function()
    end,
    ft = 'plantuml',
  },
}
