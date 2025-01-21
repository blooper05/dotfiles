return {
  {
    'lambdalisue/vim-gin', -- non-lua plugin
    dependencies = {
      { 'vim-denops/denops.vim' }, -- non-lua plugin
    },
    init = function()
      vim.g['gin_branch_default_args'] = { '--all', '--verbose', '--verbose' }

      vim.g['gin_log_default_args'] = { '--graph', '--pretty=pretty' }
      vim.g['gin_log_persistent_args'] = { '--no-show-signature' }

      vim.g['gin_proxy_apply_without_confirm'] = true
    end,
    cmd = 'Gin',
    keys = {
      { '[git]', '<Nop>' },
      { '<Space>g', '[git]', remap = true },

      -- stylua: ignore start
      { '[git]b', function() vim.cmd('GinBranch --all --verbose --verbose') end,                       silent = true },
      { '[git]c', function() vim.cmd('Gin commit --verbose') end,                                      silent = true },
      { '[git]C', function() vim.cmd('Gin commit --amend --verbose') end,                              silent = true },
      { '[git]l', function() vim.cmd('GinLog --graph --pretty=pretty --no-show-signature') end,        silent = true },
      { '[git]L', function() vim.cmd('GinLog --graph --pretty=pretty --no-show-signature -- %:p') end, silent = true },
      { '[git]p', function() vim.cmd('GinPatch %:p') end,                                              silent = true },
      { '[git]R', function() vim.cmd('GinBuffer reflog') end,                                          silent = true },
      { '[git]s', function() vim.cmd('GinStatus') end,                                                 silent = true },
      { '[git]o', function() vim.cmd('GinBrowse') end,                                                 silent = true },
      -- stylua: ignore end
    },
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
    'isakbm/gitgraph.nvim',
    dependencies = {
      { 'sindrets/diffview.nvim' },
    },
    opts = {
      hooks = {
        on_select_commit = function(commit)
          vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
        end,
        on_select_range_commit = function(from, to)
          vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        end,
      },
    },
    keys = {
      -- stylua: ignore start
      { '[git]g', function() require('gitgraph').draw({}, { revision_range = '--no-show-signature' }) end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'akinsho/git-conflict.nvim',
    config = true,
    event = 'BufReadPost',
  },
}
