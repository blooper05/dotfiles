return {
  {
    'pwntester/octo.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim'            },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.keymap.set('n', '[octo]',       '<Nop>',  {})
      vim.keymap.set('n', '[telescope]G', '[octo]', { remap = true })

      vim.keymap.set('n', '[octo]i', '<Cmd>Octo issue list<CR>', { silent = true })
      vim.keymap.set('n', '[octo]p', '<Cmd>Octo pr list<CR>',    { silent = true })

      require('octo').setup({})
    end,
  },
}
