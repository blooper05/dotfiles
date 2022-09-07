return {
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      local hlslens = require('hlslens')

      vim.keymap.set('n', 'n', function() vim.cmd([[execute('normal! ' . v:count1 . 'n')]]) hlslens.start() end, { silent = true })
      vim.keymap.set('n', 'N', function() vim.cmd([[execute('normal! ' . v:count1 . 'N')]]) hlslens.start() end, { silent = true })
    end,
    event = 'VimEnter',
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

      vim.g['asterisk#keeppos'] = true
    end,
    event = 'VimEnter',
  },
}
