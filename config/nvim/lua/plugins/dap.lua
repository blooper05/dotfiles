return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

      vim.keymap.set('n', '[dap]',    '<Nop>', {})
      vim.keymap.set('n', '<Space>d', '[dap]', { remap = true })

      vim.keymap.set('n', '[dap]r', dap.repl.open,         { silent = true })
      vim.keymap.set('n', '[dap]b', dap.toggle_breakpoint, { silent = true })
      vim.keymap.set('n', '[dap]c', dap.continue,          { silent = true })
    end,
    event = 'VimEnter',
  },

  {
    'rcarriga/nvim-dap-ui',
    requires = {
      { 'mfussenegger/nvim-dap' },
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')

      vim.keymap.set('n', '[dap]d', dapui.toggle, { silent = true })

      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config']     = function() dapui.close() end

      dapui.setup({})
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
