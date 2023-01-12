return {
  {
    'pwntester/octo.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    cmd = 'Octo',
    keys = {
      { '[octo]', '<Nop>' },
      { '[telescope]G', '[octo]', remap = true },

      {
        '[octo]i',
        function()
          vim.cmd('Octo issue list')
        end,
        silent = true,
      },
      {
        '[octo]p',
        function()
          vim.cmd('Octo pr list')
        end,
        silent = true,
      },
    },
  },
}
