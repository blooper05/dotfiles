return {
  {
    'chaoren/vim-wordmotion', -- non-lua plugin
    setup = function() end,
    keys = { 'w', 'W', 'b', 'B', 'e', 'E', 'ge', 'gE', 'aw', 'aW', 'iw', 'iW', '<C-R><C-W>', '<C-R><C-A>' },
  },

  {
    'andymass/vim-matchup', -- non-lua plugin
    requires = {
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        matchup = {
          enable = true,
        },
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
      vim.keymap.set('', 'y', '<Plug>(operator-flashy)', { remap = true })
      vim.keymap.set('n', 'Y', '<Plug>(operator-flashy)$', { remap = true })
    end,
    wants = 'vim-operator-user',
    keys = { 'y', 'Y' },
  },

  {
    'rhysd/vim-operator-surround', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.keymap.set('o', 's', '<Plug>(operator-surround-append)', { remap = true, silent = true })
      vim.keymap.set('x', 's', '<Plug>(operator-surround-append)', { remap = true, silent = true })
      vim.keymap.set('', 'ds', '<Plug>(operator-surround-delete)a', { remap = true, silent = true })
      vim.keymap.set('', 'cs', '<Plug>(operator-surround-replace)a', { remap = true, silent = true })
    end,
    wants = 'vim-operator-user',
    keys = { 's', 'ds', 'cs' },
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
    wants = 'vim-operator-user',
    keys = 'p',
  },
}
