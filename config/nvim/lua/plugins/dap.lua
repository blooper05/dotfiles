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

      -- stylua: ignore start
      { '[dap]c', function() require('dap').continue() end,          silent = true },
      { '[dap]b', function() require('dap').toggle_breakpoint() end, silent = true },
      { '[dap]r', function() require('dap').repl.toggle() end,       silent = true },
      -- stylua: ignore end
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
      -- stylua: ignore start
      { '[dap]d', function() require('dapui').toggle() end, silent = true },
      -- stylua: ignore end
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
      { 'saghen/blink.cmp' },
      { 'saghen/blink.compat' },
    },
    config = function()
      require('blink.cmp').setup({
        sources = {
          per_filetype = {
            ['dap-repl'] = { 'dap' },
            dapui_watches = { 'dap' },
            dapui_hover = { 'dap' },
          },
          providers = {
            dap = {
              module = 'blink.compat.source',
              name = 'dap',
              enabled = function()
                return vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= 'prompt'
                  or require('cmp_dap').is_dap_buffer()
              end,
            },
          },
        },
      })
    end,
  },
}
