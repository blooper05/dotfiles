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
      -- stylua: ignore start
      { '[git]hi', function() vim.cmd('Octo issue list') end, silent = true },
      { '[git]hp', function() vim.cmd('Octo pr list') end,    silent = true },
      -- stylua: ignore end
    },
  },

  {
    'David-Kunz/gen.nvim',
    opts = {
      model = 'gemma2:27b',
      show_prompt = true,
      show_model = true,
    },
    cmd = 'Gen',
    keys = {
      -- stylua: ignore start
      { '<Leader>g', function() vim.cmd('Gen') end,             silent = true },
      { '<Leader>g', [[:<C-u>'<,'>Gen<CR>]],        mode = 'v', silent = true },
      -- stylua: ignore end
    },
  },

  {
    'Exafunction/codeium.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = true,
    cmd = 'Codeium',
  },
}
