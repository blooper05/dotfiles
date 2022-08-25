return {
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      vim.keymap.set('', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
      vim.keymap.set('', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
    end,
  },

  {
    'haya14busa/vim-asterisk', -- non-lua plugin
    requires = {
      { 'kevinhwang91/nvim-hlslens' },
    },
    config = function()
      vim.keymap.set('', '*',  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  { remap = true })
      vim.keymap.set('', '#',  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  { remap = true })
      vim.keymap.set('', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
    end,
  },
}
