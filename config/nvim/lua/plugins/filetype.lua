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
    'cameron-wags/rainbow_csv.nvim',
    config = true,
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
    config = function()
      require('autolist').setup()

      -- stylua: ignore start
      vim.keymap.set('i', '<Tab>',   '<Cmd>AutolistTab<CR>')
      vim.keymap.set('i', '<S-Tab>', '<Cmd>AutolistShiftTab<CR>')

      vim.keymap.set('i', '<CR>', '<CR><Cmd>AutolistNewBullet<CR>')
      vim.keymap.set('n', 'o',    'o<Cmd>AutolistNewBullet<CR>')
      vim.keymap.set('n', 'O',    'O<Cmd>AutolistNewBulletBefore<CR>')

      vim.keymap.set('n', '>>', '>><Cmd>AutolistRecalculate<CR>')
      vim.keymap.set('n', '<<', '<<<Cmd>AutolistRecalculate<CR>')
      vim.keymap.set('n', 'dd', 'dd<Cmd>AutolistRecalculate<CR>')
      vim.keymap.set('v', 'd',  'd<Cmd>AutolistRecalculate<CR>')
      -- stylua: ignore end
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

  -- Terraform

  {
    'mvaldes14/terraform.nvim',
    ft = 'terraform',
    enabled = false, -- TODO:
  },
}
