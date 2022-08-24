return {
  {
    'pwntester/octo.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim'            },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[octo]',       '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]G', '[octo]', {})

      vim.api.nvim_set_keymap('n', '[octo]i', '<Cmd>Octo issue list<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[octo]p', '<Cmd>Octo pr list<CR>',    { noremap = true, silent = true })

      require('octo').setup({})
    end,
  },
}
