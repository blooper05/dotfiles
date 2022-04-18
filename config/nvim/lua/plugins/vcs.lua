return {
  {
    'lambdalisue/gina.vim', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '[gina]',   '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>g', '[gina]', {})

      vim.api.nvim_set_keymap('n', '[gina]a', ':<C-u>Gina add -- %:p<CR>',           { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]r', ':<C-u>Gina reset --quiet -- %:p<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]B', ':<C-u>Gina blame<CR>',                { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]b', ':<C-u>Gina branch --all<CR>',         { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]c', ':<C-u>Gina commit<CR>',               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]C', ':<C-u>Gina commit --amend<CR>',       { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]l', ':<C-u>Gina log --graph<CR>',          { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]L', ':<C-u>Gina log --graph -- %:p<CR>',   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]d', ':<C-u>Gina compare<CR>',              { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]D', ':<C-u>Gina compare --cached<CR>',     { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]p', ':<C-u>Gina patch %:p<CR>',            { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]R', ':<C-u>Gina reflog<CR>',               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]s', ':<C-u>Gina status<CR>',               { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '[gina]P', ':<C-u>Gina push<CR>',                 { noremap = true, silent = true })

      -- gina-buffer-blame specific settings.
      vim.call('gina#custom#action#alias', 'blame', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'blame', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'blame', 'p', [[:<C-u>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'blame', 'c', [[:<C-u>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
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
      vim.call('gina#custom#mapping#nmap', 'log', 'p', [[:<C-u>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'log', 'c', [[:<C-u>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'log', 'setlocal cursorline')

      -- gina-buffer-reflog specific settings.
      vim.call('gina#custom#action#alias', 'reflog', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'reflog', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'reflog', 'p', [[:<C-u>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'reflog', 'c', [[:<C-u>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
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
