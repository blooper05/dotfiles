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
      vim.keymap.set('n', '<Leader>r', '<Plug>SnipRun', { silent = true })
      vim.keymap.set('v', '<Leader>r', '<Plug>SnipRun', { silent = true })
    end,
    event = 'VimEnter',
  },

  {
    'vim-test/vim-test', -- non-lua plugin
    config = function()
      vim.keymap.set('n', '<Leader>c', '<Cmd>TestFile<CR>',    { silent = true })
      vim.keymap.set('n', '<Leader>n', '<Cmd>TestNearest<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>l', '<Cmd>TestLast<CR>',    { silent = true })
      vim.keymap.set('n', '<Leader>a', '<Cmd>TestSuite<CR>',   { silent = true })
    end,
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

  {
    'ishchow/nvim-deardiary',
    config = function()
      require('deardiary.config').journals = {
        {
          path        = '~/.local/share/journals',
          frequencies = { 'daily', 'weekly', 'monthly', 'yearly' },
        },
      }

      local deardiary = vim.api.nvim_create_augroup('deardiary', { clear = true })
      vim.api.nvim_create_autocmd('VimEnter', {
        group    = deardiary,
        callback = function()
          require('deardiary').set_current_journal_cwd()
        end,
      })
    end,
    event = 'VimEnter',
  },
}
