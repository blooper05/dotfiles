return {
  -- Natural Language

  {
    'uga-rosa/translate.nvim',
    config = function()
      vim.keymap.set('x', '<Leader>te', function()
        vim.cmd('Translate EN')
      end, { silent = true })

      vim.keymap.set('x', '<Leader>tj', function()
        vim.cmd('Translate JA')
      end, { silent = true })

      require('translate').setup({
        default = {
          output = 'replace',
        },
      })
    end,
    cmd = 'Translate',
    keys = { '<Leader>te', '<Leader>tj' },
  },

  {
    'koron/codic-vim', -- non-lua plugin
    config = function() end,
    cmd = 'Codic',
  },

  -- CSV

  {
    'mechatroner/rainbow_csv', -- non-lua plugin
    config = function() end,
    ft = 'csv',
  },

  -- Jsonnet

  {
    'google/vim-jsonnet', -- non-lua plugin
    config = function() end,
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
      { 'tyru/open-browser.vim', opt = true },
    },
    config = function()
      vim.keymap.set('n', '<Leader>p', function()
        vim.cmd('PrevimOpen')
      end, { silent = true })
    end,
    wants = 'open-browser.vim',
    ft = 'markdown',
  },

  -- PlantUML

  {
    'aklt/plantuml-syntax', -- non-lua plugin
    config = function() end,
    ft = 'plantuml',
  },
}
