return {
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
}
