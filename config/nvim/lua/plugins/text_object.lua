return {
  {
    'bkad/CamelCaseMotion', -- non-lua plugin
    config = function()
      vim.g.camelcasemotion_key = ''
    end,
    event = 'VimEnter',
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
    after = 'nvim-treesitter',
  },

  {
    'haya14busa/vim-operator-flashy', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.keymap.set('',  'y', '<Plug>(operator-flashy)',  { remap = true })
      vim.keymap.set('n', 'Y', '<Plug>(operator-flashy)$', { remap = true })
    end,
    event = 'VimEnter',
  },

  {
    'rhysd/vim-operator-surround', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.keymap.set('o', 's',  '<Plug>(operator-surround-append)',   { remap = true, silent = true })
      vim.keymap.set('x', 's',  '<Plug>(operator-surround-append)',   { remap = true, silent = true })
      vim.keymap.set('',  'ds', '<Plug>(operator-surround-delete)a',  { remap = true, silent = true })
      vim.keymap.set('',  'cs', '<Plug>(operator-surround-replace)a', { remap = true, silent = true })
    end,
    event = 'VimEnter',
  },

  {
    'kana/vim-operator-replace', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.keymap.set('o', 'p', '<Plug>(operator-replace)', { remap = true, silent = true })
      vim.keymap.set('x', 'p', '<Plug>(operator-replace)', { remap = true, silent = true })
    end,
    event = 'VimEnter',
  },
}
