return {
  -- Natural Language

  {
    'potamides/pantran.nvim',
    opts = {
      default_engine = 'google',
    },
    cmd = 'Pantran',
    keys = {
      -- stylua: ignore start
      { '<Leader>te', function() require('pantran').range_translate({ target = 'en' }) end, mode = 'x', silent = true },
      { '<Leader>tj', function() require('pantran').range_translate({ target = 'ja' }) end, mode = 'x', silent = true },
      -- stylua: ignore end
    },
  },

  {
    'koron/codic-vim', -- non-lua plugin
    cmd = 'Codic',
  },

  -- CSV

  {
    'mechatroner/rainbow_csv', -- non-lua plugin
    ft = 'csv',
  },

  -- Jsonnet

  {
    'google/vim-jsonnet', -- non-lua plugin
    ft = 'jsonnet',
  },

  -- Markdown

  {
    'gaoDean/autolist.nvim',
    dependencies = {
      { 'windwp/nvim-autopairs' }, -- FIXME: conflicted with
    },
    config = function()
      local autolist = require('autolist')

      autolist.setup()

      vim.keymap.set('i', '<Tab>', '<Cmd>AutolistTab<CR>')
      vim.keymap.set('i', '<S-Tab>', '<Cmd>AutolistShiftTab<CR>')
      vim.keymap.set('i', '<CR>', '<CR><Cmd>AutolistNewBullet<CR>')
      vim.keymap.set('n', 'o', 'o<Cmd>AutolistNewBullet<CR>')
      vim.keymap.set('n', 'O', 'O<Cmd>AutolistNewBulletBefore<CR>')
      vim.keymap.set('n', '<CR>', '<Cmd>AutolistToggleCheckbox<CR><CR>')
      vim.keymap.set('n', '<C-r>', '<Cmd>AutolistRecalculate<CR><C-r>')

      vim.keymap.set('n', '<leader>cn', autolist.cycle_next_dr, { expr = true })
      vim.keymap.set('n', '<leader>cp', autolist.cycle_prev_dr, { expr = true })

      vim.keymap.set('n', '>>', '>><Cmd>AutolistRecalculate<CR>')
      vim.keymap.set('n', '<<', '<<<Cmd>AutolistRecalculate<CR>')
      vim.keymap.set('n', 'dd', 'dd<Cmd>AutolistRecalculate<CR>')
      vim.keymap.set('v', 'd', 'd<Cmd>AutolistRecalculate<CR>')
    end,
    ft = 'markdown',
  },

  {
    'previm/previm', -- non-lua plugin
    dependencies = {
      { 'tyru/open-browser.vim' }, -- non-lua plugin
    },
    ft = 'markdown',
    keys = {
      -- stylua: ignore start
      { '<Leader>p', function() vim.cmd('PrevimOpen') end, silent = true },
      -- stylua: ignore end
    },
  },

  -- PlantUML

  {
    'aklt/plantuml-syntax', -- non-lua plugin
    ft = 'plantuml',
  },
}
