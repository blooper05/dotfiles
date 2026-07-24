return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'b0o/schemastore.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
      { 'mason-org/mason.nvim' },
      { 'zapling/mason-lock.nvim' },
    },
    config = function()
      local servers = {
        'bashls',
        'cssls',
        'cssmodules_ls',
        'denols',
        'docker_compose_language_service',
        'docker_language_server',
        'elmls',
        'eslint',
        'gh_actions_ls',
        'gopls',
        'helm_ls',
        'html',
        'jsonls',
        'jsonnet_ls',
        'lua_ls',
        'markdown_oxide',
        'marksman',
        'postgres_lsp',
        'pylsp',
        'remark_ls',
        'ruby_lsp',
        -- 'solargraph',
        -- 'sorbet',
        'sqls',
        -- 'steep',
        'stylelint_lsp',
        'taplo',
        'terraformls',
        'ts_ls',
        'yamlls',
      }

      local schemastore = require('schemastore')

      vim.lsp.config('jsonls', {
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
          },
        },
      })
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { library = { vim.env.VIMRUNTIME } },
          },
        },
      })
      vim.lsp.config('remark_ls', {
        settings = {
          remark = {
            requireConfig = false,
          },
        },
      })
      vim.lsp.config('yamlls', {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = '' },
            schemas = schemastore.yaml.schemas(),
          },
        },
      })

      require('mason').setup()
      require('mason-lock').setup({ lockfile_path = vim.fn.stdpath('config') .. '/mason-lock.json' })
      require('mason-lspconfig').setup({ ensure_installed = servers })
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
    config = true,
    cmd = 'Trouble',
    keys = {
      -- stylua: ignore start
      { '[lsp]l', function() vim.cmd('Trouble diagnostics toggle') end, silent = true },
      -- stylua: ignore end
    },
  },
}
