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

  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            schema = { model = { default = 'codestral:22b' } },
          })
        end,
      },
      strategies = {
        -- stylua: ignore start
        chat   = { adapter = 'ollama' },
        inline = { adapter = 'ollama' },
        cmd    = { adapter = 'ollama' },
        -- stylua: ignore end
      },
      display = {
        chat = {
          auto_scroll = false,
          show_header_separator = true,
          start_in_insert_mode = true,
        },
      },
      opts = {
        language = 'Japanese',
        send_code = false,
      },
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions' },
  },

  -- {
  --   'David-Kunz/gen.nvim',
  --   opts = {
  --     model = 'mistral-small3.1:24b',
  --     show_prompt = true,
  --     show_model = true,
  --   },
  --   cmd = 'Gen',
  --   keys = {
  --     -- stylua: ignore start
  --     { '<Leader>g', function() vim.cmd('Gen') end,             silent = true },
  --     { '<Leader>g', [[:<C-u>'<,'>Gen<CR>]],        mode = 'v', silent = true },
  --     -- stylua: ignore end
  --   },
  -- },

  {
    'Exafunction/codeium.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = true,
    cmd = 'Codeium',
  },

  -- TODO: { 'GCBallesteros/jupytext.nvim' },
  -- TODO: { 'epwalsh/obsidian.nvim' },
  -- TODO: { 'epwalsh/pomo.nvim' }
  -- TODO: { 'romgrk/todoist.nvim' }
}
