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
    'tadmccorkle/markdown.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      mappings = false,
      on_attach = function(bufnr)
        -- stylua: ignore start
        vim.keymap.set('i', '<Tab>',   '<Tab><Cmd>MDResetListNumbering<CR>',   { buffer = bufnr })
        vim.keymap.set('i', '<S-Tab>', '<S-Tab><Cmd>MDResetListNumbering<CR>', { buffer = bufnr })

        vim.keymap.set('i', '<CR>', '<Cmd>MDListItemBelow<CR><CR><BS>', { buffer = bufnr })
        vim.keymap.set('n', 'o',    '<Cmd>MDListItemBelow<CR>o<BS>',    { buffer = bufnr })
        vim.keymap.set('n', 'O',    '<Cmd>MDListItemAbove<CR>O<BS>',    { buffer = bufnr })

        vim.keymap.set('n', '>>', '>><Cmd>MDResetListNumbering<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<<', '<<<Cmd>MDResetListNumbering<CR>', { buffer = bufnr })
        vim.keymap.set('n', 'dd', 'dd<Cmd>MDResetListNumbering<CR>', { buffer = bufnr })
        vim.keymap.set('v', 'd',  'd<Cmd>MDResetListNumbering<CR>',  { buffer = bufnr })
        -- stylua: ignore end
      end,
    },
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
