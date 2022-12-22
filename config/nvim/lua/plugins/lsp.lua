return {
  {
    'neovim/nvim-lspconfig',
    requires = {
      { 'williamboman/mason-lspconfig.nvim', opt = true, module = 'mason-lspconfig' },
      { 'williamboman/mason.nvim', opt = true, module = 'mason' },
    },
    setup = function()
      vim.keymap.set('n', '[lsp]',    '<Nop>', {})
      vim.keymap.set('n', '<Space>l', '[lsp]', { remap = true })
    end,
    config = function()
      local mason          = require('mason')
      local masonLspconfig = require('mason-lspconfig')
      local nvimLspconfig  = require('lspconfig')

      local servers = {
        'bashls',
        'cssls',
        'cssmodules_ls',
        'dockerls',
        'elmls',
        'eslint',
        'grammarly',
        'html',
        'jsonls',
        'jsonnet_ls',
        'pylsp',
        -- 'remark_ls',
        'ruby_ls',
        'solargraph',
        -- 'sorbet',
        'sqlls',
        'sqls',
        'stylelint_lsp',
        'sumneko_lua',
        'tailwindcss',
        'taplo',
        'terraformls',
        'tsserver',
        'volar',
        -- 'vuels',
        'yamlls',
      }

      mason.setup({
        max_concurrent_installers = 8,
      })

      masonLspconfig.setup({
        ensure_installed       = servers,
        automatic_installation = true,
      })

      masonLspconfig.setup_handlers({
        function(server_name)
          nvimLspconfig[server_name].setup({})
        end,

        ['sumneko_lua'] = function()
          nvimLspconfig.sumneko_lua.setup({
            settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
          })
        end,
      })
    end,
    event = 'BufReadPre',
  },

  {
    'glepnir/lspsaga.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    setup = function()
      vim.keymap.set('n', '[lsp]r', function() vim.cmd('Lspsaga rename')            end, { silent = true })
      vim.keymap.set('n', '[lsp]a', function() vim.cmd('Lspsaga code_action')       end, { silent = true })
      vim.keymap.set('x', '[lsp]a', function() vim.cmd('Lspsaga range_code_action') end, { silent = true })
      vim.keymap.set('n', '[lsp]d', function() vim.cmd('Lspsaga hover_doc')         end, { silent = true })
      vim.keymap.set('n', '[lsp]f', function() vim.cmd('Lspsaga lsp_finder')        end, { silent = true })
    end,
    config = function()
      require('lspsaga').init_lsp_saga({})
    end,
    after = 'nvim-lspconfig',
    cmd = 'Lspsaga',
    keys = '[lsp]',
  },

  {
    'folke/trouble.nvim',
    requires = {
      { 'neovim/nvim-lspconfig'                   },
      { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    setup = function()
      vim.keymap.set('n', '[lsp]l', function() vim.cmd('TroubleToggle') end, { silent = true })
    end,
    config = function()
      require('trouble').setup({})
    end,
    after = 'nvim-lspconfig',
    cmd = 'TroubleToggle',
    keys = '[lsp]',
  },
}
