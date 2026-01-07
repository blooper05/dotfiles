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
      { 'MeanderingProgrammer/render-markdown.nvim', ft = 'codecompanion' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'ravitemer/mcphub.nvim' },
    },
    opts = {
      adapters = {
        acp = {
          claude_code = function()
            return require('codecompanion.adapters').extend('claude_code', {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = [[cmd:op read 'op://Personal/Claude Code/credential' --no-newline]],
              },
            })
          end,
        },
        http = {
          ['gpt-oss'] = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = { model = { default = 'gpt-oss:20b' } },
            })
          end,
          devstral = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = { model = { default = 'devstral-small-2:24b' } },
            })
          end,
          mistral = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = { model = { default = 'mistral-small3.2:24b' } },
            })
          end,
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              schema = { model = { default = 'us.anthropic.claude-sonnet-4-5-20250929-v1:0' } },
            })
          end,
        },
      },
      opts = {
        language = 'Japanese',
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
        },
      },
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions' },
    keys = {
      -- stylua: ignore start
      { '<Leader>ca',    function() vim.cmd('CodeCompanionChat Add') end,    mode = 'v',               silent = true },
      { '<Leader>cc',    function() vim.cmd('CodeCompanionChat Toggle') end, mode = { 'n', 'v' },      silent = true },
      { '[telescope]cc', function() require('telescope').extensions.codecompanion.codecompanion() end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = true,
    cmd = 'MCPHub',
  },

  {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = { markdown = true, help = true },
    },
    event = 'InsertEnter',
    cmd = 'Copilot',
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
