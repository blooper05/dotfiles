return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.actionlint,
          -- null_ls.builtins.diagnostics.alex,
          null_ls.builtins.diagnostics.editorconfig_checker,
          null_ls.builtins.diagnostics.gitlint,
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.eslint,
          null_ls.builtins.formatting.markdownlint,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.shfmt,
          -- null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.formatting.terrafmt,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.trim_newlines,
          -- null_ls.builtins.formatting.trim_whitespace,
        },
        on_attach = function(client)
          if client.resolved_capabilities.document_formatting then
            local lspFormatting = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group   = lspFormatting,
              pattern = '<buffer>',
              command = 'lua vim.lsp.buf.formatting_sync()',
            })
          end
        end,
      })
    end,
    after = 'nvim-lsp-installer',
  },

  {
    'michaelb/sniprun', run = 'bash ./install.sh',
    config = function()
      local sniprun = require('sniprun')

      vim.keymap.set('n', '<Leader>r', sniprun.run, { silent = true })
      vim.keymap.set('v', '<Leader>r', sniprun.run, { silent = true })

      sniprun.setup({
        display = { 'TerminalWithCode' },
      })
    end,
    event = 'VimEnter',
  },

  {
    'nvim-neotest/neotest',
    requires = {
      { 'antoinemadec/FixCursorHold.nvim' },
      { 'nvim-lua/plenary.nvim'           },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'olimorris/neotest-rspec'         },
    },
    config = function()
      local neotest = require('neotest')

      vim.keymap.set('n', '<Leader>c', function() neotest.run.run(vim.fn.expand('%')) end, { silent = true })
      vim.keymap.set('n', '<Leader>n', function() neotest.run.run()                   end, { silent = true })
      vim.keymap.set('n', '<Leader>l', function() neotest.run.run_last()              end, { silent = true })
      vim.keymap.set('n', '<Leader>a', function() neotest.run.run(vim.fn.getcwd())    end, { silent = true })

      neotest.setup({
        adapters = {
          require('neotest-rspec'),
        },
      })
    end,
    event = 'VimEnter',
  },

  {
    'previm/previm', -- non-lua plugin
    requires = {
      { 'tyru/open-browser.vim' },
    },
    config = function()
      vim.keymap.set('n', '<Leader>p', '<Cmd>PrevimOpen<CR>', { silent = true })
    end,
  },

  -- TODO: { 'renerocksai/telekasten.nvim' },
}
