return {
  {
    'potamides/pantran.nvim',
    opts = function()
      return {
        default_engine = 'deepl',
        engines = {
          deepl = { auth_key = vim.fn.system([[op read 'op://Personal/DeepL API/credential' --no-newline]]) },
        },
      }
    end,
    cmd = 'Pantran',
    keys = {
      -- stylua: ignore start
      { '<Leader>te', [[:<C-u>'<,'>Pantran source=ja target=en<CR>]], mode = 'x', silent = true },
      { '<Leader>tj', [[:<C-u>'<,'>Pantran source=en target=ja<CR>]], mode = 'x', silent = true },
      -- stylua: ignore end
    },
  },

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

  -- TODO: { 'GCBallesteros/jupytext.nvim' },
  -- TODO: { 'epwalsh/obsidian.nvim' },
  -- TODO: { 'epwalsh/pomo.nvim' }
  -- TODO: { 'romgrk/todoist.nvim' }
}
