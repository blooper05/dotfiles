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
        'remark_ls',
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
    'tami5/lspsaga.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      vim.keymap.set('n', '[lsp]r', '<Cmd>Lspsaga rename<CR>',            { silent = true })
      vim.keymap.set('n', '[lsp]a', '<Cmd>Lspsaga code_action<CR>',       { silent = true })
      vim.keymap.set('x', '[lsp]a', '<Cmd>Lspsaga range_code_action<CR>', { silent = true })
      vim.keymap.set('n', '[lsp]d', '<Cmd>Lspsaga hover_doc<CR>',         { silent = true })

      require('lspsaga').setup({})
    end,
    after = 'nvim-lsp-installer',
  },

  {
    'folke/trouble.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.keymap.set('n', '[lsp]l', '<Cmd>TroubleToggle<CR>', { silent = true })

      require('trouble').setup({})
    end,
    after = 'nvim-lsp-installer',
  },
}
