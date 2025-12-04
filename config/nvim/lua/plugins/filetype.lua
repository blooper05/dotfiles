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
    'yousefhadder/markdown-plus.nvim',
    ft = 'markdown',
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
