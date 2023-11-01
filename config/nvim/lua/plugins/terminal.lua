return {
  {
    'akinsho/toggleterm.nvim',
    opts = {
      size = vim.opt.columns:get() * 0.4,
      open_mapping = '<Leader>t',
      direction = 'vertical',
    },
    cmd = 'ToggleTerm',
    keys = '<Leader>t',
  },
}
