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

      vim.api.nvim_set_keymap('n', '[lsp]',    '<Nop>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>l', '[lsp]', {})
    end,
    after = 'nvim-lspconfig',
  },

  {
    'tami5/lspsaga.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[lsp]r', '<Cmd>Lspsaga rename<CR>',             { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[lsp]a', '<Cmd>Lspsaga code_action<CR>',        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', '[lsp]a', ':<C-u>Lspsaga range_code_action<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[lsp]d', '<Cmd>Lspsaga hover_doc<CR>',          { noremap = true, silent = true })

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
      vim.api.nvim_set_keymap('n', '[lsp]l', '<Cmd>TroubleToggle<CR>', { noremap = true, silent = true })

      require('trouble').setup({})
    end,
    after = 'nvim-lsp-installer',
  },
}
