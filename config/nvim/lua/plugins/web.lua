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
      -- stylua: ignore start
    },
  },

  {
    'robitx/gp.nvim',
    opts = {
      providers = {
        openai = { disable = true },
        ollama = { disable = false },
      },

      -- stylua: ignore start
      chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Leader>r' },
      chat_shortcut_delete  = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Leader>d' },
      chat_shortcut_stop    = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Leader>s' },
      chat_shortcut_new     = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Leader>c' },
      -- stylua: ignore start
    },
    cmd = { 'GpChatNew', 'GpChatPaste', 'GpChatToggle', 'GpChatFinder' },
    keys = {
      -- stylua: ignore start
      { '<Leader>g',    function() vim.cmd('GpChatToggle') end,             silent = true },
      { '<Leader>g',    [[:<C-u>'<,'>GpChatToggle<CR>]],        mode = 'v', silent = true },
      { '[telescope]G', function() vim.cmd('GpChatFinder') end,             silent = true },
      -- stylua: ignore start
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
