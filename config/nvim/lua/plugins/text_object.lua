return {
  {
    'folke/which-key.nvim',
    config = true,
    cmd = 'WhichKey',
    keys = {
      -- stylua: ignore start
      { '<Leader>w', function() vim.cmd('WhichKey') end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'chrisgrieser/nvim-spider',
    config = true,
    keys = {
      -- stylua: ignore start
      { 'w',  function() require('spider').motion('w') end,  mode = { 'n', 'o', 'x' }, remap = true, silent = true },
      { 'b',  function() require('spider').motion('b') end,  mode = { 'n', 'o', 'x' }, remap = true, silent = true },
      { 'e',  function() require('spider').motion('e') end,  mode = { 'n', 'o', 'x' }, remap = true, silent = true },
      { 'ge', function() require('spider').motion('ge') end, mode = { 'n', 'o', 'x' }, remap = true, silent = true },
      -- stylua: ignore end
    },
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
      { 'kana/vim-operator-user' }, -- non-lua plugin
    },
    keys = {
      -- stylua: ignore start
      { 'y', '<Plug>(operator-flashy)',  mode = '',  remap = true },
      { 'Y', '<Plug>(operator-flashy)$', mode = 'n', remap = true },
      -- stylua: ignore end
    },
  },

  {
    'rhysd/vim-operator-surround', -- non-lua plugin
    dependencies = {
      { 'kana/vim-operator-user' }, -- non-lua plugin
    },
    keys = {
      -- stylua: ignore start
      { 's',  '<Plug>(operator-surround-append)',   mode = { 'o', 'x' }, remap = true, silent = true },
      { 'ds', '<Plug>(operator-surround-delete)a',  mode = '',           remap = true, silent = true },
      { 'cs', '<Plug>(operator-surround-replace)a', mode = '',           remap = true, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'kana/vim-operator-replace', -- non-lua plugin
    dependencies = {
      { 'kana/vim-operator-user' }, -- non-lua plugin
    },
    keys = {
      -- stylua: ignore start
      { 'p', '<Plug>(operator-replace)', mode = { 'o', 'x' }, remap = true, silent = true },
      -- stylua: ignore end
    },
  },

  -- TODO: { 'kylechui/nvim-surround' },
  -- TODO: { 'nvim-treesitter/nvim-treesitter-textobjects' },
}
