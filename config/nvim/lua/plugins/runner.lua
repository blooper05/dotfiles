return {
  {
    'dense-analysis/ale', -- non-lua plugin
    config = function()
      -- Run linters only when I save files.
      vim.g.ale_lint_on_text_changed = 'never'
      vim.g.ale_lint_on_insert_leave = false
      vim.g.ale_lint_on_enter        = false

      -- Run formatters when I save files.
      vim.g.ale_fix_on_save = true

      vim.g.ale_fixers = {
        ['*']           = { 'remove_trailing_lines' },
        ruby            = { 'rubocop' },
        json            = { 'eslint', 'prettier' },
        javascript      = { 'eslint', 'prettier' },
        typescript      = { 'eslint', 'prettier' },
        typescriptreact = { 'eslint', 'prettier' },
        vue             = { 'eslint', 'prettier' },
        terraform       = { 'terraform' },
      }

      -- Run linters or formatters via Docker.
      local pwd = vim.api.nvim_call_function('getcwd', {})

      vim.g.ale_ruby_rubocop_executable = 'docker-rubocop'

      vim.g.ale_filename_mappings = {
        ruby = { { pwd, '/app' } },
      }
    end,
  },

  {
    'thinca/vim-quickrun', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>r', '<Plug>(quickrun)', {})
    end,
  },

  {
    'vim-test/vim-test', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>c', ':<C-u>TestFile<CR>',    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>n', ':<C-u>TestNearest<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>l', ':<C-u>TestLast<CR>',    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>a', ':<C-u>TestSuite<CR>',   { noremap = true, silent = true })
    end,
  },

  {
    'previm/previm', -- non-lua plugin
    requires = {
      { 'tyru/open-browser.vim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>p', ':<C-u>PrevimOpen<CR>', { noremap = true, silent = true })
    end,
  },
}
