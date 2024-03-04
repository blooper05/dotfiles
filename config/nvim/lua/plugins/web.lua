return {
  {
    'pwntester/octo.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      ssh_aliases = {},
    },
    cmd = 'Octo',
    keys = {
      { '[octo]', '<Nop>' },
      { '[telescope]G', '[octo]', remap = true },

      -- stylua: ignore start
      { '[octo]i', function() vim.cmd('Octo issue list') end, silent = true },
      { '[octo]p', function() vim.cmd('Octo pr list') end,    silent = true },
      -- stylua: ignore start
    },
  },

  {
    'jackMort/ChatGPT.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
      keymaps = {
        scroll_up = false,
        scroll_down = false,
      },
    },
    cmd = 'ChatGPT',
  },

  -- TODO: { 'Bryley/neoai.nvim' },
  -- TODO: { 'dpayne/CodeGPT.nvim' },
  -- TODO: { 'robitx/gp.nvim' },

  {
    'Exafunction/codeium.nvim',
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = true,
    cmd = 'Codeium',
  },

  -- TODO: { 'GCBallesteros/jupytext.nvim' },
}
