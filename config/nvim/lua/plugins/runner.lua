return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      { 'lukas-reineke/lsp-format.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = function()
      local null_ls = require('null-ls')
      local lsp_format = require('lsp-format')

      local diagnostics = null_ls.builtins.diagnostics
      local formatting = null_ls.builtins.formatting

      return {
        sources = {
          diagnostics.actionlint,
          diagnostics.dotenv_linter,
          -- diagnostics.editorconfig_checker.with({ command = 'ec' }),
          -- diagnostics.gitlint.with({ filetypes = { 'gitcommit' } }),
          diagnostics.hadolint,
          diagnostics.markdownlint_cli2,
          diagnostics.markuplint,
          diagnostics.reek,
          diagnostics.rubocop.with({ command = 'docker-compose-rubocop' }),
          diagnostics.sqlfluff.with({ extra_args = { '--dialect', 'postgres' } }),
          diagnostics.textlint.with({ filetypes = { 'markdown' }, prefer_local = 'node_modules/.bin' }),
          diagnostics.tfsec,
          diagnostics.trivy,
          diagnostics.yamllint,
          formatting.packer,
          formatting.prettier.with({ prefer_local = 'node_modules/.bin' }),
          formatting.rubocop.with({ command = 'docker-compose-rubocop' }),
          formatting.shfmt,
          formatting.sqlfluff.with({ extra_args = { '--dialect', 'postgres' } }),
          formatting.stylua,
          formatting.terraform_fmt,
          formatting.terragrunt_fmt,
          formatting.textlint.with({ filetypes = { 'markdown' }, prefer_local = 'node_modules/.bin' }),
          formatting.yamlfmt,
        },
        on_attach = lsp_format.on_attach,
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
      { 'nvim-neotest/nvim-nio' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'olimorris/neotest-rspec', ft = 'ruby' },
    },
    opts = function()
      return {
        adapters = {
          require('neotest-rspec')({
            rspec_cmd = 'docker-compose-rspec',
            formatter = 'json',
          }),
        },
      }
    end,
    keys = {
      -- stylua: ignore start
      { '<Leader>c', function() require('neotest').run.run(vim.fn.expand('%')) end,      silent = true },
      { '<Leader>n', function() require('neotest').run.run() end,                        silent = true },
      { '<Leader>l', function() require('neotest').run.run_last() end,                   silent = true },
      { '<Leader>a', function() require('neotest').run.run(vim.fn.getcwd()) end,         silent = true },
      { '<Leader>d', function() require('neotest').run.run({ strategy = 'dap' }) end,    silent = true },
      { '<Leader>w', function() require('neotest').watch.toggle(vim.fn.expand('%')) end, silent = true },
      -- stylua: ignore end
    },
  },
}
