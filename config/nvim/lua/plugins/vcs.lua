return {
  {
    'tanvirtin/vgit.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      live_blame = {
        enabled = false,
      },
      live_gutter = {
        enabled = false,
      },
      authorship_code_lens = {
        enabled = false,
      },
      scene = {
        diff_preference = 'split',
      },
    },
    cmd = 'VGit',
    keys = {
      { '[git]', '<Nop>' },
      { '<Space>g', '[git]', remap = true },

      { '[git]a', function() vim.cmd('VGit buffer_stage') end,                silent = true },
      { '[git]r', function() vim.cmd('VGit buffer_unstage') end,              silent = true },
      { '[git]B', function() vim.cmd('VGit buffer_gutter_blame_preview') end, silent = true },
      { '[git]b', function() vim.cmd('Telescope git_branches') end,           silent = true },
      { '[git]c', function() vim.cmd('VGit project_commit_preview') end,      silent = true },
      -- { '[git]C', function() vim.cmd('Gina commit --amend') end,              silent = true },
      { '[git]l', function() vim.cmd('Telescope git_commits') end,            silent = true },
      { '[git]L', function() vim.cmd('Telescope git_bcommits') end,           silent = true },
      { '[git]d', function() vim.cmd('VGit buffer_diff_preview') end,         silent = true },
      { '[git]D', function() vim.cmd('VGit buffer_diff_staged_preview') end,  silent = true },
      -- { '[git]R', function() vim.cmd('Gina reflog') end,                      silent = true },
      { '[git]s', function() vim.cmd('Telescope git_status') end,             silent = true },
    },
  },

  -- TODO: { 'TimUntersberger/neogit' },
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
