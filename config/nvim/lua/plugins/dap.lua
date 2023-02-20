return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/cmp-dap' },
      { 'rcarriga/nvim-dap-ui' },
      { 'suketa/nvim-dap-ruby', ft = 'ruby' },
      { 'theHamsta/nvim-dap-virtual-text' },
    },
    cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapToggleRepl' },
    keys = {
      { '[dap]', '<Nop>' },
      { '<Space>d', '[dap]', remap = true },

      {
        '[dap]c',
        function()
          require('dap').continue()
        end,
        silent = true,
      },
      {
        '[dap]b',
        function()
          require('dap').toggle_breakpoint()
        end,
        silent = true,
      },
      {
        '[dap]r',
        function()
          require('dap').repl.toggle()
        end,
        silent = true,
      },
    },
  },

  {
    'rcarriga/nvim-dap-ui',
    config = function()
      local dap, dapui = require('dap'), require('dapui')

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      dapui.setup({})
    end,
    keys = {
      {
        '[dap]d',
        function()
          require('dapui').toggle()
        end,
        silent = true,
      },
    },
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = true,
  },

  {
    'rcarriga/cmp-dap',
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      require('cmp').setup({
        enabled = function()
          return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
        end,
      })

      require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
        sources = {
          { name = 'dap' },
        },
      })
    end,
  },
}
