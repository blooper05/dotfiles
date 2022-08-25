return {
  {
    'williamboman/nvim-lsp-installer',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      local installer = require('nvim-lsp-installer.servers')
      local servers   = installer.get_available_server_names()

      for _, name in pairs(servers) do
        local serverAvailable, server = installer.get_server(name)

        if serverAvailable then
          server:on_ready(function()
            local opts = {}

            for serverName in pairs({ 'denols', 'ltex', 'remark_ls', 'sorbet' }) do
              if server.name == serverName then
                opts.autostart = false
              end
            end

            if server.name == 'sumneko_lua' then
              opts.settings = { Lua = { diagnostics = { globals = { 'use', 'vim' } } } }
            end

            server:setup(opts)
          end)

          if not server:is_installed() then
            server:install()
          end
        end
      end

      vim.keymap.set('n', '[lsp]',    '<Nop>', {})
      vim.keymap.set('n', '<Space>l', '[lsp]', { remap = true })
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
