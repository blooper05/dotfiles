return {
  {
    'mfussenegger/nvim-dap',
    setup = function()
      vim.keymap.set('n', '[dap]', '<Nop>', {})
      vim.keymap.set('n', '<Space>d', '[dap]', { remap = true })
    end,
    config = function()
      local dap = require('dap')

      vim.keymap.set('n', '[dap]c', dap.continue, { silent = true })
      vim.keymap.set('n', '[dap]b', dap.toggle_breakpoint, { silent = true })
      vim.keymap.set('n', '[dap]r', dap.repl.toggle, { silent = true })
    end,
    cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapToggleRepl' },
    keys = '[dap]',
  },

  {
    'rcarriga/nvim-dap-ui',
    requires = {
      { 'mfussenegger/nvim-dap' },
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')

      vim.keymap.set('n', '[dap]d', dapui.toggle, { silent = true })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      dapui.setup({})
    end,
    after = 'nvim-dap',
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    requires = {
      { 'mfussenegger/nvim-dap' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('nvim-dap-virtual-text').setup({})
    end,
    after = 'nvim-dap',
  },

  {
    'suketa/nvim-dap-ruby',
    requires = {
      { 'mfussenegger/nvim-dap' },
    },
    config = function()
      require('dap-ruby').setup({})
    end,
    after = 'nvim-dap',
  },
}
