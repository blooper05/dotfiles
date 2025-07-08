return {
  {
    'coder/claudecode.nvim',
    dependencies = {
      { 'folke/snacks.nvim' },
    },
    config = true,
    keys = {
      { '[claudecode]', '<Nop>' },
      { '<Space>c', '[claudecode]', remap = true },

      -- stylua: ignore start
      { '[claudecode]c', function() vim.cmd('ClaudeCode')            end },
      { '[claudecode]f', function() vim.cmd('ClaudeCodeFocus')       end },
      { '[claudecode]r', function() vim.cmd('ClaudeCode --resume')   end },
      { '[claudecode]C', function() vim.cmd('ClaudeCode --continue') end },
      { '[claudecode]b', function() vim.cmd('ClaudeCodeAdd %')       end },
      { '[claudecode]s', function() vim.cmd('ClaudeCodeSend')        end, mode = 'v' },
      { '[claudecode]s', function() vim.cmd('ClaudeCodeTreeAdd')     end, ft = { 'NvimTree', 'oil' } },
      { '[claudecode]a', function() vim.cmd('ClaudeCodeDiffAccept')  end },
      { '[claudecode]d', function() vim.cmd('ClaudeCodeDiffDeny')    end },
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
            schema = { model = { default = 'devstral:24b' } },
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
      },
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions' },
    keys = {
      -- stylua: ignore start
      { '<Leader>gg', [[:CodeCompanion ]],                                mode = 'n',          silent = false },
      { '<Leader>gg', [[:<C-u>'<,'>CodeCompanion ]],                      mode = 'v',          silent = false },
      { '<Leader>ga', function() vim.cmd('CodeCompanionActions')     end, mode = { 'n', 'v' }, silent = true },
      { '<Leader>gc', function() vim.cmd('CodeCompanionChat Toggle') end, mode = { 'n', 'v' }, silent = true },
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
