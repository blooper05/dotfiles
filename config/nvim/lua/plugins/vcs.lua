return {
  {
    'lambdalisue/gina.vim', -- non-lua plugin
    setup = function()
      vim.keymap.set('n', '[gina]',   '<Nop>',  {})
      vim.keymap.set('n', '<Space>g', '[gina]', { remap = true })
    end,
    config = function()
      vim.keymap.set('n', '[gina]a', function() vim.cmd('Gina add -- %:p')           end, { silent = true })
      vim.keymap.set('n', '[gina]r', function() vim.cmd('Gina reset --quiet -- %:p') end, { silent = true })
      vim.keymap.set('n', '[gina]B', function() vim.cmd('Gina blame')                end, { silent = true })
      vim.keymap.set('n', '[gina]b', function() vim.cmd('Gina branch --all')         end, { silent = true })
      vim.keymap.set('n', '[gina]c', function() vim.cmd('Gina commit')               end, { silent = true })
      vim.keymap.set('n', '[gina]C', function() vim.cmd('Gina commit --amend')       end, { silent = true })
      vim.keymap.set('n', '[gina]l', function() vim.cmd('Gina log --graph')          end, { silent = true })
      vim.keymap.set('n', '[gina]L', function() vim.cmd('Gina log --graph -- %:p')   end, { silent = true })
      vim.keymap.set('n', '[gina]d', function() vim.cmd('Gina compare')              end, { silent = true })
      vim.keymap.set('n', '[gina]D', function() vim.cmd('Gina compare --cached')     end, { silent = true })
      vim.keymap.set('n', '[gina]p', function() vim.cmd('Gina patch %:p')            end, { silent = true })
      vim.keymap.set('n', '[gina]R', function() vim.cmd('Gina reflog')               end, { silent = true })
      vim.keymap.set('n', '[gina]s', function() vim.cmd('Gina status')               end, { silent = true })
      -- vim.keymap.set('n', '[gina]P', function() vim.cmd('Gina push')                 end, { silent = true })

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
      vim.call('gina#custom#action#alias', 'log', 'preview', 'vertical show:commit:preview')
      vim.call('gina#custom#action#alias', 'log', 'changes', 'vertical changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'log', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'log', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'log', 'setlocal cursorline')

      -- gina-buffer-reflog specific settings.
      vim.call('gina#custom#action#alias', 'reflog', 'preview', 'vertical show:commit:preview')
      vim.call('gina#custom#action#alias', 'reflog', 'changes', 'vertical changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'reflog', 'p', [[<Cmd>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'reflog', 'c', [[<Cmd>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'reflog', 'setlocal cursorline')

      -- gina-buffer-status specific settings.
      vim.call('gina#custom#command#option', 'status', '--branch')
      vim.call('gina#custom#command#option', 'status', '--short')
      vim.call('gina#custom#execute', 'status', 'setlocal cursorline')
    end,
    cmd = 'Gina',
    keys = '[gina]',
  },

  -- TODO: { 'TimUntersberger/neogit' },
  -- TODO: { 'f-person/git-blame.nvim' },
  -- TODO: { 'sindrets/diffview.nvim' },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({})
    end,
    event = 'VimEnter',
  },
}
