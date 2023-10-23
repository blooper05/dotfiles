return {
  {
    'lambdalisue/gin.vim',
    dependencies = {
      { 'vim-denops/denops.vim' },
    },
    cmd = 'Gin',
    keys = {
      { '[git]', '<Nop>' },
      { '<Space>g', '[git]', remap = true },

      -- { '[git]a', function() vim.cmd('Gin add -- %:p') end,                   silent = true },
      -- { '[git]r', function() vim.cmd('Gin reset --quiet -- %:p') end,         silent = true },
      -- { '[git]B', function() vim.cmd('Gin blame') end,                        silent = true },
      -- { '[git]b', function() vim.cmd('GinBranch --all') end,                  silent = true },
      -- { '[git]c', function() vim.cmd('Gin commit') end,                       silent = true },
      -- { '[git]C', function() vim.cmd('Gin commit --amend') end,               silent = true },
      -- { '[git]l', function() vim.cmd('GinLog') end,                           silent = true },
      -- { '[git]L', function() vim.cmd('GinLog -- %:p') end,                    silent = true },
      -- { '[git]d', function() vim.cmd('GinDiff') end,                          silent = true },
      -- { '[git]D', function() vim.cmd('GinDiff --cached') end,                 silent = true },
      -- { '[git]R', function() vim.cmd('Gin reflog') end,                       silent = true },
      -- { '[git]s', function() vim.cmd('GinStatus') end,                        silent = true },
    },
  },

  {
    'lambdalisue/gina.vim',
    config = function()
      local opts = { noremap = true, silent = true }

      -- gina-buffer-blame specific settings.
      vim.call('gina#custom#action#alias', 'blame', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'blame', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'blame', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], opts)
      vim.call('gina#custom#mapping#nmap', 'blame', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], opts)
      vim.call('gina#custom#execute', 'blame', 'setlocal cursorline')

      -- gina-buffer-branch specific settings.
      vim.call('gina#custom#mapping#nmap', 'branch', 'co', '<Plug>(gina-commit-checkout)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'ct', '<Plug>(gina-commit-checkout-track)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'M',  '<Plug>(gina-branch-move)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'D',  '<Plug>(gina-branch-delete)')
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
      { '[git]a', function() vim.cmd('Gina add -- %:p') end,                       silent = true },
      { '[git]r', function() vim.cmd('Gina reset --quiet -- %:p') end,             silent = true },
      { '[git]B', function() vim.cmd('Gina blame') end,                            silent = true },
      { '[git]b', function() vim.cmd('Gina branch --all --verbose --verbose') end, silent = true },
      { '[git]c', function() vim.cmd('Gina commit') end,                           silent = true },
      { '[git]C', function() vim.cmd('Gina commit --amend') end,                   silent = true },
      { '[git]l', function() vim.cmd('Gina log --graph') end,                      silent = true },
      { '[git]L', function() vim.cmd('Gina log --graph -- %:p') end,               silent = true },
      { '[git]d', function() vim.cmd('Gina compare') end,                          silent = true },
      { '[git]D', function() vim.cmd('Gina compare --cached') end,                 silent = true },
      { '[git]p', function() vim.cmd('Gina patch %:p') end,                        silent = true },
      { '[git]R', function() vim.cmd('Gina reflog') end,                           silent = true },
      { '[git]s', function() vim.cmd('Gina status') end,                           silent = true },
    },
  },

  -- TODO: { 'TimUntersberger/neogit' },
  -- TODO: { 'akinsho/git-conflict.nvim' },
  -- TODO: { 'f-person/git-blame.nvim' },
  -- TODO: { 'sindrets/diffview.nvim' },

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
    },
    event = 'BufReadPost',
    cmd = 'Gitsigns',
  },
}
