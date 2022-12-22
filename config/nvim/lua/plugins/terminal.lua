return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = '<Leader>t',
        direction = 'float',
      })
    end,
    cmd = 'ToggleTerm',
    keys = '<Leader>t',
  },
}
