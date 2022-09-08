return {
  {
    'williamboman/mason.nvim',
    requires = {
      { 'neovim/nvim-lspconfig'             },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      vim.keymap.set('n', '[lsp]',    '<Nop>', {})
      vim.keymap.set('n', '<Space>l', '[lsp]', { remap = true })

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
        'vuels',
        'yamlls',
      }

      mason.setup({})

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
    after = 'nvim-lspconfig',
  },

  {
    'glepnir/lspsaga.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      vim.keymap.set('n', '[lsp]r', function() vim.cmd('Lspsaga rename')            end, { silent = true })
      vim.keymap.set('n', '[lsp]a', function() vim.cmd('Lspsaga code_action')       end, { silent = true })
      vim.keymap.set('x', '[lsp]a', function() vim.cmd('Lspsaga range_code_action') end, { silent = true })
      vim.keymap.set('n', '[lsp]d', function() vim.cmd('Lspsaga hover_doc')         end, { silent = true })
      vim.keymap.set('n', '[lsp]f', function() vim.cmd('Lspsaga lsp_finder')        end, { silent = true })

      require('lspsaga').init_lsp_saga({})
    end,
    after = 'mason.nvim',
  },

  {
    'folke/trouble.nvim',
    requires = {
      { 'neovim/nvim-lspconfig'                    },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.keymap.set('n', '[lsp]l', function() vim.cmd('TroubleToggle') end, { silent = true })

      require('trouble').setup({})
    end,
    after = 'mason.nvim',
  },

  {
    'j-hui/fidget.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      require('fidget').setup({})
    end,
    after = 'mason.nvim',
  },
}
