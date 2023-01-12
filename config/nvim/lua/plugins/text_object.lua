return {
  {
    'chaoren/vim-wordmotion', -- non-lua plugin
    keys = { 'w', 'W', 'b', 'B', 'e', 'E', 'ge', 'gE', 'aw', 'aW', 'iw', 'iW', '<C-R><C-W>', '<C-R><C-A>' },
  },

  {
    'andymass/vim-matchup', -- non-lua plugin
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        matchup = {
          enable = true,
        },
      })
    end,
    event = 'BufReadPost',
  },

  {
    'haya14busa/vim-operator-flashy', -- non-lua plugin
    dependencies = {
      { 'kana/vim-operator-user' },
    },
    keys = {
      { 'y', '<Plug>(operator-flashy)', mode = '', remap = true },
      { 'Y', '<Plug>(operator-flashy)$', mode = 'n', remap = true },
    },
  },

  {
    'rhysd/vim-operator-surround', -- non-lua plugin
    dependencies = {
      { 'kana/vim-operator-user' },
    },
    keys = {
      { 's', '<Plug>(operator-surround-append)', mode = 'o', remap = true, silent = true },
      { 's', '<Plug>(operator-surround-append)', mode = 'x', remap = true, silent = true },
      { 'ds', '<Plug>(operator-surround-delete)a', mode = '', remap = true, silent = true },
      { 'cs', '<Plug>(operator-surround-replace)a', mode = '', remap = true, silent = true },
    },
  },

  {
    'kana/vim-operator-replace', -- non-lua plugin
    dependencies = {
      { 'kana/vim-operator-user' },
    },
    keys = {
      { 'p', '<Plug>(operator-replace)', mode = 'o', remap = true, silent = true },
      { 'p', '<Plug>(operator-replace)', mode = 'x', remap = true, silent = true },
    },
  },
}
