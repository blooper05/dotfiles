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

  -- Markdown

  {
    'gaoDean/autolist.nvim',
    config = true,
    ft = 'markdown',
    keys = {
      -- stylua: ignore start
      { '<Tab>',   '<Cmd>AutolistTab<CR>',              mode = 'i', ft = 'markdown' },
      { '<S-Tab>', '<Cmd>AutolistShiftTab<CR>',         mode = 'i', ft = 'markdown' },
      { '<CR>',    '<CR><Cmd>AutolistNewBullet<CR>',    mode = 'i', ft = 'markdown' },
      { 'o',       'o<Cmd>AutolistNewBullet<CR>',       mode = 'n', ft = 'markdown' },
      { 'O',       'O<Cmd>AutolistNewBulletBefore<CR>', mode = 'n', ft = 'markdown' },
      { '>>',      '>><Cmd>AutolistRecalculate<CR>',    mode = 'n', ft = 'markdown' },
      { '<<',      '<<<Cmd>AutolistRecalculate<CR>',    mode = 'n', ft = 'markdown' },
      { 'dd',      'dd<Cmd>AutolistRecalculate<CR>',    mode = 'n', ft = 'markdown' },
      { 'd',       'd<Cmd>AutolistRecalculate<CR>',     mode = 'v', ft = 'markdown' },
      -- stylua: ignore end
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      completions = { blink = { enabled = true } },
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

  -- Golang

  {
    'ray-x/go.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'ray-x/guihua.lua' },
    },
    config = function(_, opts)
      require('go').setup(opts)

      local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end,
    ft = { 'go', 'gomod' },
  },
}
