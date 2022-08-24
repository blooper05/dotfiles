return {
  {
    'lambdalisue/gina.vim', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '[gina]',   '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>g', '[gina]', {})

      vim.api.nvim_set_keymap('n', '[gina]a', '<Cmd>Gina add -- %:p<CR>',           { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]r', '<Cmd>Gina reset --quiet -- %:p<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]B', '<Cmd>Gina blame<CR>',                { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]b', '<Cmd>Gina branch --all<CR>',         { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]c', '<Cmd>Gina commit<CR>',               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]C', '<Cmd>Gina commit --amend<CR>',       { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]l', '<Cmd>Gina log --graph<CR>',          { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]L', '<Cmd>Gina log --graph -- %:p<CR>',   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]d', '<Cmd>Gina compare<CR>',              { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]D', '<Cmd>Gina compare --cached<CR>',     { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]p', '<Cmd>Gina patch %:p<CR>',            { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]R', '<Cmd>Gina reflog<CR>',               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]s', '<Cmd>Gina status<CR>',               { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '[gina]P', '<Cmd>Gina push<CR>',                 { noremap = true, silent = true })

      -- gina-buffer-blame specific settings.
      vim.call('gina#custom#action#alias', 'blame', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'blame', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'blame', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'blame', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
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
      vim.call('gina#custom#action#alias', 'log', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'log', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'log', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'log', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'log', 'setlocal cursorline')

      -- gina-buffer-reflog specific settings.
      vim.call('gina#custom#action#alias', 'reflog', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'reflog', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'reflog', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'reflog', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'reflog', 'setlocal cursorline')

      -- gina-buffer-status specific settings.
      vim.call('gina#custom#command#option', 'status', '--branch')
      vim.call('gina#custom#command#option', 'status', '--short')
      vim.call('gina#custom#execute', 'status', 'setlocal cursorline')
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({})
    end,
  },
}
