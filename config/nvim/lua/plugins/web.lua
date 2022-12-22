return {
  {
    'pwntester/octo.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    setup = function()
      vim.keymap.set('n', '[octo]', '<Nop>', {})
      vim.keymap.set('n', '[telescope]G', '[octo]', { remap = true })
    end,
    config = function()
      vim.keymap.set('n', '[octo]i', function() vim.cmd('Octo issue list') end, { silent = true })
      vim.keymap.set('n', '[octo]p', function() vim.cmd('Octo pr list') end, { silent = true })

      require('octo').setup({})
    end,
    after = 'telescope.nvim',
    cmd = 'Octo',
    keys = '[octo]',
  },
}
