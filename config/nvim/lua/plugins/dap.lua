return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.keymap.set('n', '[dap]',    '<Nop>', {})
      vim.keymap.set('n', '<Space>d', '[dap]', { remap = true })

      vim.keymap.set('n', '[dap]r', require('dap').repl.open,         { silent = true })
      vim.keymap.set('n', '[dap]b', require('dap').toggle_breakpoint, { silent = true })
      vim.keymap.set('n', '[dap]c', require('dap').continue,          { silent = true })
    end,
    event = 'VimEnter',
  },

  {
    'rcarriga/nvim-dap-ui',
    requires = {
      { 'mfussenegger/nvim-dap' },
    },
    config = function()
      vim.keymap.set('n', '[dap]d', require('dapui').toggle, { silent = true })

      require('dapui').setup({})
    end,
    after = 'nvim-dap',
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    requires = {
      { 'mfussenegger/nvim-dap'           },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('nvim-dap-virtual-text').setup({})
    end,
    after = 'nvim-dap',
  },
}
