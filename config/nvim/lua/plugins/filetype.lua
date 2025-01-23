return {
  -- Natural Language

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
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    ft = 'markdown',
    keys = {
      -- stylua: ignore start
      { '<Leader>p', function() vim.cmd('RenderMarkdown toggle') end, silent = true },
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
