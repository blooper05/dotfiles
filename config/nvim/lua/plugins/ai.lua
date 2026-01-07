return {
  {
    'coder/claudecode.nvim',
    dependencies = {
      { 'folke/snacks.nvim' },
    },
    opts = {
      terminal = {
        split_width_percentage = 0.4,
      },
    },
    keys = {
      { '[claudecode]', '<Nop>' },
      { '<Space>c', '[claudecode]', remap = true },

      -- stylua: ignore start
      { '[claudecode]c', function() vim.cmd('ClaudeCodeFocus')       end },
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
