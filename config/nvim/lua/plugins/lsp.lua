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
    end,
    after = 'nvim-lspconfig',
  },

  {
    'tami5/lspsaga.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      require('lspsaga').setup({})
    end,
  },
}
