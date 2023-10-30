return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'williamboman/mason.nvim' },
    },
    config = function()
      local mason = require('mason')
      local masonLspconfig = require('mason-lspconfig')
      local nvimLspconfig = require('lspconfig')

      local servers = {
        'bashls',
        'cssls',
        'cssmodules_ls',
        'docker_compose_language_service',
        'dockerls',
        'elmls',
        'eslint',
        'grammarly',
        'html',
        'jsonls',
        'jsonnet_ls',
        'lua_ls',
        'nginx-language-server',
        'postgres_lsp',
        'pylsp',
        'remark_ls',
        'rubocop',
        'ruby_ls',
        'solargraph',
        'sorbet',
        'sqlls',
        'sqls',
        'steep',
        'stylelint_lsp',
        'tailwindcss',
        'taplo',
        'terraformls',
        'tflint',
        'tsserver',
        'typeprof',
        'volar',
        'yamlls',
      }

      mason.setup({
        max_concurrent_installers = 8,
      })

      masonLspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      masonLspconfig.setup_handlers({
        function(server_name)
          nvimLspconfig[server_name].setup({})
        end,
        ['lua_ls'] = function()
          nvimLspconfig.lua_ls.setup({
            settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
          })
        end,
        ['ruby_ls'] = function()
          nvimLspconfig.ruby_ls.setup({
            init_options = {
              enabledFeatures = { 'codeActions', 'diagnostics', 'documentHighlights', 'documentSymbols', 'inlayHint' },
            },
          })
        end,
      })
    end,
    event = 'BufReadPost',
    keys = {
      { '[lsp]', '<Nop>' },
      { '<Space>l', '[lsp]', remap = true },
    },
  },

  {
    'glepnir/lspsaga.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = true,
    cmd = 'Lspsaga',
    keys = {
      {
        '[lsp]r',
        function()
          vim.cmd('Lspsaga rename')
        end,
        silent = true,
      },
      {
        '[lsp]a',
        function()
          vim.cmd('Lspsaga code_action')
        end,
        silent = true,
      },
      {
        '[lsp]d',
        function()
          vim.cmd('Lspsaga hover_doc')
        end,
        silent = true,
      },
      {
        '[lsp]f',
        function()
          vim.cmd('Lspsaga lsp_finder')
        end,
        silent = true,
      },
    },
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    cmd = 'TroubleToggle',
    keys = {
      {
        '[lsp]l',
        function()
          vim.cmd('TroubleToggle')
        end,
        silent = true,
      },
    },
  },
}
