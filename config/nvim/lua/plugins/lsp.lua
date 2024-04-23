return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'VonHeikemen/lsp-zero.nvim' },
      { 'b0o/schemastore.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'williamboman/mason.nvim' },
    },
    config = function()
      local servers = {
        'bashls',
        'cssls',
        'cssmodules_ls',
        'docker_compose_language_service',
        'dockerls',
        'elmls',
        'eslint',
        'grammarly',
        'helm_ls',
        'html',
        'jsonls',
        'jsonnet_ls',
        'lua_ls',
        -- 'nginx-language-server',
        -- 'postgres_lsp',
        'pylsp',
        -- 'remark_ls',
        'ruby_lsp',
        'solargraph',
        'sorbet',
        'sqlls',
        -- 'steep',
        'stylelint_lsp',
        'tailwindcss',
        'taplo',
        'terraformls',
        'tsserver',
        -- 'typeprof',
        'volar',
        'yamlls',
      }

      local lspconfig = require('lspconfig')
      local lsp_zero = require('lsp-zero')
      local schemastore = require('schemastore')

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = servers,
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
          end,
          jsonls = function()
            lspconfig.jsonls.setup({
              settings = {
                json = {
                  schemas = schemastore.json.schemas(),
                  validate = { enable = true },
                },
              },
            })
          end,
          yamlls = function()
            lspconfig.yamlls.setup({
              settings = {
                yaml = {
                  schemaStore = { enable = false, url = '' },
                  schemas = schemastore.yaml.schemas(),
                },
              },
            })
          end,
        },
      })
    end,
    event = 'BufReadPost',
    keys = {
      { '[lsp]', '<Nop>' },
      { '<Space>l', '[lsp]', remap = true },
    },
  },

  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = true,
    cmd = 'Lspsaga',
    keys = {
      -- stylua: ignore start
      { '[lsp]r', function() vim.cmd('Lspsaga rename') end,      silent = true },
      { '[lsp]a', function() vim.cmd('Lspsaga code_action') end, silent = true },
      { '[lsp]d', function() vim.cmd('Lspsaga hover_doc') end,   silent = true },
      { '[lsp]f', function() vim.cmd('Lspsaga finder') end,      silent = true },
      -- stylua: ignore end
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
      -- stylua: ignore start
      { '[lsp]l', function() vim.cmd('TroubleToggle') end, silent = true },
      -- stylua: ignore end
    },
  },
}
