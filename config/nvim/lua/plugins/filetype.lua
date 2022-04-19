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

  {
    'ishchow/nvim-deardiary',
    config = function()
      require('deardiary.config').journals = {
        {
          path        = '~/.local/share/journals',
          frequencies = { 'daily', 'weekly', 'monthly', 'yearly' },
        },
      }

      local deardiary = vim.api.nvim_create_augroup('deardiary', { clear = true })
      vim.api.nvim_create_autocmd('VimEnter', {
        group    = deardiary,
        callback = function()
          require('deardiary').set_current_journal_cwd()
        end,
      })
    end,
  },

  -- Markdown {{{2

  {
    'rcmdnk/vim-markdown', -- non-lua plugin
    requires = {
      { 'joker1007/vim-markdown-quote-syntax' },
      { 'godlygeek/tabular'                   },
    },
    config = function()
      -- Disable the folding configuration.
      vim.g.vim_markdown_folding_disabled = true
    end,
  },

  -- PlantUML {{{2

  {
    'aklt/plantuml-syntax', -- non-lua plugin
    config = function()
    end,
  },

  -- Terraform {{{2

  {
    'hashivim/vim-terraform', -- non-lua plugin
    config = function()
    end,
  },

  -- nginx {{{2

  {
    'chr4/nginx.vim', -- non-lua plugin
    config = function()
    end,
  },

  -- CSV {{{2

  {
    'mechatroner/rainbow_csv', -- non-lua plugin
    config = function()
    end,
  },

  -- Jsonnet {{{2

  {
    'google/vim-jsonnet', -- non-lua plugin
    config = function()
    end,
  },
}
