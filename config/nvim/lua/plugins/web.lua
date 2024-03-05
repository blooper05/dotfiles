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
    'jackMort/ChatGPT.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
      api_key_cmd = [[op read 'op://Personal/OpenAI API/credential' --no-newline]],
    },
    cmd = 'ChatGPT',
    enable = false, -- TODO:
  },

  {
    'robitx/gp.nvim',
    opts = {
      openai_api_key = { 'op', 'read', 'op://Personal/OpenAI API/credential', '--no-newline' },

      -- stylua: ignore start
      chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Space>gr' },
      chat_shortcut_delete  = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Space>gd' },
      chat_shortcut_stop    = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Space>gs' },
      chat_shortcut_new     = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Space>gc' },
      -- stylua: ignore start
    },
    cmd = { 'GpChatNew', 'GpChatPTPaste', 'GpChatToggle', 'GpChatFinder' },
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
      { 'hrsh7th/nvim-cmp' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = true,
    cmd = 'Codeium',
  },
}
