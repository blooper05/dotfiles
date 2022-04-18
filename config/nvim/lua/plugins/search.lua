return {
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      vim.api.nvim_set_keymap('', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
    end,
  },

  {
    'haya14busa/vim-asterisk', -- non-lua plugin
    requires = {
      { 'kevinhwang91/nvim-hlslens' },
    },
    config = function()
      vim.api.nvim_set_keymap('', '*',  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  {})
      vim.api.nvim_set_keymap('', '#',  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  {})
      vim.api.nvim_set_keymap('', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
    end,
  },
}
