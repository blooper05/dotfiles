return {
  -- Natural Language

  {
    'uga-rosa/translate.nvim',
    init = function()
      vim.g.deepl_api_auth_key = ''
    end,
    opts = {
      default = {
        command = 'deepl_free',
        output = 'replace',
      },
    },
    cmd = 'Translate',
    keys = {
      {
        '<Leader>te',
        function()
          vim.cmd('Translate EN')
        end,
        mode = 'x',
        silent = true,
      },

      {
        '<Leader>tj',
        function()
          vim.cmd('Translate JA')
        end,
        mode = 'x',
        silent = true,
      },
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
    config = function()
      local autolist = require('autolist')

      autolist.setup()

      -- FIXME: conflicting with nvim-cmp
      autolist.create_mapping_hook('i', '<CR>', autolist.new)
      autolist.create_mapping_hook('i', '<Tab>', autolist.indent)
      autolist.create_mapping_hook('i', '<S-Tab>', autolist.indent, '<C-D>')
      autolist.create_mapping_hook('n', 'dd', autolist.force_recalculate)
      autolist.create_mapping_hook('n', 'o', autolist.new)
      autolist.create_mapping_hook('n', 'O', autolist.new_before)
      autolist.create_mapping_hook('n', '>>', autolist.indent)
      autolist.create_mapping_hook('n', '<<', autolist.indent)
      autolist.create_mapping_hook('n', '<C-r>', autolist.force_recalculate)
      autolist.create_mapping_hook('n', '<leader>x', autolist.invert_entry, '')
    end,
    ft = 'markdown',
  },

  {
    'previm/previm', -- non-lua plugin
    dependencies = {
      { 'tyru/open-browser.vim' },
    },
    ft = 'markdown',
    keys = {
      {
        '<Leader>p',
        function()
          vim.cmd('PrevimOpen')
        end,
        silent = true,
      },
    },
  },
}
