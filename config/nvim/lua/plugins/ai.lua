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
        http = {
          ['gpt-oss'] = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = { model = { default = 'gpt-oss:20b' } },
            })
          end,
          devstral = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = { model = { default = 'devstral:24b' } },
            })
          end,
          mistral = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = { model = { default = 'mistral-small3.2:24b' } },
            })
          end,
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              schema = { model = { default = 'us.anthropic.claude-opus-4-1-20250805-v1:0' } },
            })
          end,
        },
      },
      strategies = {
        -- stylua: ignore start
        chat   = { adapter = 'devstral' },
        inline = { adapter = 'devstral' },
        cmd    = { adapter = 'devstral' },
        -- stylua: ignore end
      },
      opts = {
        language = 'Japanese',
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_tools = true,
            show_server_tools_in_chat = true,
            add_mcp_prefix_to_tool_names = false,
            show_result_in_chat = true,
            format_tool = nil,
            make_vars = true,
            make_slash_commands = true,
          },
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
