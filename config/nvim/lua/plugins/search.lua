return {
  {
    'kevinhwang91/nvim-hlslens',
    requires = {
      { 'petertriho/nvim-scrollbar', opt = true },
    },
    config = function()
      vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
      vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })

      require('scrollbar.handlers.search').setup({})
    end,
    keys = { 'n', 'N', '*', '#', 'g*', 'g#' },
  },

  {
    'haya14busa/vim-asterisk', -- non-lua plugin
    requires = {
      { 'kevinhwang91/nvim-hlslens', opt = true },
    },
    setup = function()
      vim.g['asterisk#keeppos'] = true
    end,
    config = function()
      vim.keymap.set('n', '*',  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  { remap = true })
      vim.keymap.set('n', '#',  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  { remap = true })
      vim.keymap.set('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('x', '*',  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  { remap = true })
      vim.keymap.set('x', '#',  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  { remap = true })
      vim.keymap.set('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
    end,
    after = 'nvim-hlslens',
  },
}
