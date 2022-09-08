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
          null_ls.builtins.diagnostics.eslint.with({
            prefer_local = 'node_modules/.bin',
          }),
          null_ls.builtins.diagnostics.gitlint,
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.markdownlint.with({
            prefer_local = 'node_modules/.bin',
          }),
          null_ls.builtins.diagnostics.rubocop.with({
            prefer_local = '.bundle/bin',
          }),
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.textlint.with({
            filetypes    = { 'markdown', 'text' },
            prefer_local = 'node_modules/.bin',
          }),
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.eslint.with({
            prefer_local = 'node_modules/.bin',
          }),
          null_ls.builtins.formatting.markdownlint.with({
            prefer_local = 'node_modules/.bin',
          }),
          null_ls.builtins.formatting.prettier.with({
            prefer_local = 'node_modules/.bin',
          }),
          null_ls.builtins.formatting.rubocop.with({
            prefer_local = '.bundle/bin',
          }),
          null_ls.builtins.formatting.shfmt,
          -- null_ls.builtins.formatting.sqlformat,
          -- null_ls.builtins.formatting.sql_formatter,
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.taplo,
          -- null_ls.builtins.formatting.terrafmt,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.textlint.with({
            filetypes    = { 'markdown', 'text' },
            prefer_local = 'node_modules/.bin',
          }),
          null_ls.builtins.formatting.trim_newlines,
          -- null_ls.builtins.formatting.trim_whitespace,
        },

        on_attach = function(client, bufnr)
          local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group    = augroup,
              buffer   = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end
            })
          end
        end,
      })
    end,
    after = 'mason.nvim',
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

  -- TODO: { 'renerocksai/telekasten.nvim' },
}
