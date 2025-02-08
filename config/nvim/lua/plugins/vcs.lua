return {
  {
    'lambdalisue/gina.vim', -- non-lua plugin
    config = function()
      local opts = { noremap = true, silent = true }

      -- gina-buffer-branch specific settings.
      vim.call('gina#custom#mapping#nmap', 'branch', 'co', '<Plug>(gina-commit-checkout)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'ct', '<Plug>(gina-commit-checkout-track)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'M', '<Plug>(gina-branch-move)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'D', '<Plug>(gina-branch-delete)')
      vim.call('gina#custom#execute', 'branch', 'setlocal cursorline')
      vim.call('gina#custom#command#option', 'branch', '--verbose')

      -- gina-buffer-commit specific settings.
      vim.call('gina#custom#command#option', 'commit', '--verbose')

      -- gina-buffer-log specific settings.
      vim.call('gina#custom#action#alias', 'log', 'preview', 'vertical show:commit:preview')
      vim.call('gina#custom#action#alias', 'log', 'changes', 'vertical changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'log', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], opts)
      vim.call('gina#custom#mapping#nmap', 'log', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], opts)
      vim.call('gina#custom#execute', 'log', 'setlocal cursorline')

      -- gina-buffer-reflog specific settings.
      vim.call('gina#custom#action#alias', 'reflog', 'preview', 'vertical show:commit:preview')
      vim.call('gina#custom#action#alias', 'reflog', 'changes', 'vertical changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'reflog', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], opts)
      vim.call('gina#custom#mapping#nmap', 'reflog', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], opts)
      vim.call('gina#custom#execute', 'reflog', 'setlocal cursorline')

      -- gina-buffer-status specific settings.
      vim.call('gina#custom#command#option', 'status', '--branch')
      vim.call('gina#custom#command#option', 'status', '--short')
      vim.call('gina#custom#execute', 'status', 'setlocal cursorline')
    end,
    cmd = 'Gina',
    keys = {
      { '[git]', '<Nop>' },
      { '<Space>g', '[git]', remap = true },

      -- stylua: ignore start
      { '[git]b', function() vim.cmd('Gina branch --all --verbose --verbose') end,                       silent = true },
      { '[git]c', function() vim.cmd('Gina commit --verbose') end,                                       silent = true },
      { '[git]C', function() vim.cmd('Gina commit --amend --verbose') end,                               silent = true },
      { '[git]l', function() vim.cmd('Gina log --graph --pretty=pretty --no-show-signature') end,        silent = true },
      { '[git]L', function() vim.cmd('Gina log --graph --pretty=pretty --no-show-signature -- %:p') end, silent = true },
      { '[git]p', function() vim.cmd('Gina patch %:p') end,                                              silent = true },
      { '[git]R', function() vim.cmd('Gina reflog') end,                                                 silent = true },
      { '[git]s', function() vim.cmd('Gina status') end,                                                 silent = true },
      -- stylua: ignore end
    },
  },

  {
    'chrisgrieser/nvim-tinygit',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'rcarriga/nvim-notify' },
      { 'stevearc/dressing.nvim' },
    },
    cmd = 'Tinygit',
  },

  {
    'lewis6991/gitsigns.nvim',
    init = function()
      -- Always draw the signcolumn with a space.
      vim.opt.signcolumn = 'yes:1'
    end,
    opts = {
      numhl = true,
      word_diff = true,
      current_line_blame = true,
      diff_opts = {
        ignore_whitespace_change = false,
      },
    },
    event = 'BufReadPost',
    cmd = 'Gitsigns',
    keys = {
      -- stylua: ignore start
      { '[git]B', function() require('gitsigns').blame() end,               silent = true },
      { '[git]d', function() require('gitsigns').diffthis() end,            silent = true },
      { '[git]D', function() require('gitsigns').diffthis('HEAD') end,      silent = true },
      { '[git]a', function() require('gitsigns').stage_buffer() end,        silent = true },
      { '[git]r', function() require('gitsigns').reset_buffer_index() end,  silent = true },
      { '[git]]', function() require('gitsigns').next_hunk() end,           silent = true },
      { '[git][', function() require('gitsigns').prev_hunk() end,           silent = true },
      { '[git]|', function() require('gitsigns').preview_hunk_inline() end, silent = true },
      { '[git]<', function() require('gitsigns').stage_hunk() end,          silent = true },
      { '[git]>', function() require('gitsigns').stage_hunk() end,          silent = true },
      { '[git]=', function() require('gitsigns').reset_hunk() end,          silent = true },
      -- stylua: ignore end
    },
  },

  {
    'akinsho/git-conflict.nvim',
    config = true,
    event = 'BufReadPost',
  },
}
