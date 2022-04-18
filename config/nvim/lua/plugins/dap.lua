return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.api.nvim_set_keymap('n', '[dap]',    '<Nop>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>d', '[dap]', {})

      vim.api.nvim_set_keymap('n', '[dap]r', [[<Cmd>lua require('dap').repl.open()<CR>]],         { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[dap]b', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[dap]c', [[<Cmd>lua require('dap').continue()<CR>]],          { noremap = true, silent = true })
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    requires = {
      { 'mfussenegger/nvim-dap' },
    },
    config = function()
      require('dapui').setup({})
    end,
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
  },
}
