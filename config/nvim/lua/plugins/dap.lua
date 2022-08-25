return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.keymap.set('n', '[dap]',    '<Nop>', {})
      vim.keymap.set('n', '<Space>d', '[dap]', { remap = true })

      vim.keymap.set('n', '[dap]r', [[<Cmd>lua require('dap').repl.open()<CR>]],         { silent = true })
      vim.keymap.set('n', '[dap]b', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], { silent = true })
      vim.keymap.set('n', '[dap]c', [[<Cmd>lua require('dap').continue()<CR>]],          { silent = true })
    end,
    event = 'VimEnter',
  },

  {
    'rcarriga/nvim-dap-ui',
    requires = {
      { 'mfussenegger/nvim-dap' },
    },
    config = function()
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
