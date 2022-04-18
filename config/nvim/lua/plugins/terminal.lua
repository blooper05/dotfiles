return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = '<Leader>t',
      })
    end,
  },
}
