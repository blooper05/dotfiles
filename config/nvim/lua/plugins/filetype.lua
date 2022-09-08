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

  {
    'previm/previm', -- non-lua plugin
    requires = {
      { 'tyru/open-browser.vim' },
    },
    config = function()
      vim.keymap.set('n', '<Leader>p', function() vim.cmd('PrevimOpen') end, { silent = true })
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
