return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = function()
      local null_ls = require('null-ls')

      return {
        sources = {
          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.diagnostics.dotenv_linter,
          null_ls.builtins.diagnostics.editorconfig_checker.with({ command = 'ec' }),
          null_ls.builtins.diagnostics.eslint.with({ prefer_local = 'node_modules/.bin' }),
          null_ls.builtins.diagnostics.gitlint.with({ filetypes = { 'gina-commit', 'gitcommit' } }),
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.markdownlint_cli2,
          null_ls.builtins.diagnostics.reek,
          null_ls.builtins.diagnostics.rubocop.with({ command = 'docker-rubocop' }),
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { '--dialect', 'postgres' } }),
          null_ls.builtins.diagnostics.textlint.with({ filetypes = { 'markdown' }, prefer_local = 'node_modules/.bin' }),
          null_ls.builtins.diagnostics.tfsec,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.eslint.with({ prefer_local = 'node_modules/.bin' }),
          null_ls.builtins.formatting.packer,
          null_ls.builtins.formatting.prettier.with({ prefer_local = 'node_modules/.bin' }),
          null_ls.builtins.formatting.rubocop.with({ command = 'docker-rubocop' }),
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.sqlfluff.with({ extra_args = { '--dialect', 'postgres' } }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.textlint.with({ filetypes = { 'markdown' }, prefer_local = 'node_modules/.bin' }),
          -- null_ls.builtins.formatting.trim_newlines,
          -- null_ls.builtins.formatting.trim_whitespace,
        },
        on_attach = function(client, bufnr)
          local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      }
    end,
    event = 'BufReadPost',
  },

  {
    'michaelb/sniprun',
    build = 'sh install.sh',
    opts = {
      display = { 'TerminalWithCode' },
    },
    cmd = 'SnipRun',
    keys = {
      { '<Leader>r', '<Plug>SnipRun', mode = { 'n', 'v' }, silent = true },
    },
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      { 'antoinemadec/FixCursorHold.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'olimorris/neotest-rspec', ft = 'ruby' },
    },
    opts = function()
      return {
        adapters = {
          require('neotest-rspec')({
            rspec_cmd = function()
              return vim.tbl_flatten({ 'docker-rspec' })
            end,
          }),
        },
      }
    end,
    keys = {
      -- stylua: ignore start
      { '<Leader>c', function() require('neotest').run.run(vim.fn.expand('%')) end, silent = true },
      { '<Leader>n', function() require('neotest').run.run() end,                   silent = true },
      { '<Leader>l', function() require('neotest').run.run_last() end,              silent = true },
      { '<Leader>a', function() require('neotest').run.run(vim.fn.getcwd()) end,    silent = true },
      -- stylua: ignore end
    },
  },

  -- TODO: { 'renerocksai/telekasten.nvim' },
}
