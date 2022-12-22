return {
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      vim.keymap.set('n', 'n', function()
        vim.cmd([[execute('normal! ' . v:count1 . 'n')]])
        require('hlslens').start()
      end, { silent = true })

      vim.keymap.set('n', 'N', function()
        vim.cmd([[execute('normal! ' . v:count1 . 'N')]])
        require('hlslens').start()
      end, { silent = true })
    end,
    keys = { 'n', 'N', '*', '#', 'g*', 'g#' },
  },

  {
    'haya14busa/vim-asterisk', -- non-lua plugin
    requires = {
      { 'kevinhwang91/nvim-hlslens', opt = true },
    },
    setup = function()
      -- Keep cursor position across matches.
      vim.g['asterisk#keeppos'] = true
    end,
    config = function()
      vim.keymap.set('n', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('n', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('x', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('x', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
      vim.keymap.set('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], { remap = true })
    end,
    after = 'nvim-hlslens',
  },
}
