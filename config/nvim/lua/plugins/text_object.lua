return {
  {
    'bkad/CamelCaseMotion', -- non-lua plugin
    config = function()
      vim.g.camelcasemotion_key = ''
    end,
  },

  {
    'andymass/vim-matchup', -- non-lua plugin
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }

      require('nvim-treesitter.configs').setup({
        matchup = { enable = true },
      })
    end,
  },

  {
    'haya14busa/vim-operator-flashy', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.api.nvim_set_keymap('',  'y', '<Plug>(operator-flashy)',  {})
      vim.api.nvim_set_keymap('n', 'Y', '<Plug>(operator-flashy)$', {})
    end,
  },

  {
    'rhysd/vim-operator-surround', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.api.nvim_set_keymap('o', 's',  '<Plug>(operator-surround-append)',   { silent = true })
      vim.api.nvim_set_keymap('x', 's',  '<Plug>(operator-surround-append)',   { silent = true })
      vim.api.nvim_set_keymap('',  'ds', '<Plug>(operator-surround-delete)a',  { silent = true })
      vim.api.nvim_set_keymap('',  'cs', '<Plug>(operator-surround-replace)a', { silent = true })
    end,
  },

  {
    'kana/vim-operator-replace', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.api.nvim_set_keymap('o', 'p', '<Plug>(operator-replace)', { silent = true })
      vim.api.nvim_set_keymap('x', 'p', '<Plug>(operator-replace)', { silent = true })
    end,
  },
}
