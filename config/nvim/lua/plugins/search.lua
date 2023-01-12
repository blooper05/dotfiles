return {
  {
    'kevinhwang91/nvim-hlslens',
    keys = {
      {
        'n',
        function()
          vim.cmd([[execute('normal! ' . v:count1 . 'n')]])
          require('hlslens').start()
        end,
        silent = true,
      },
      {
        'N',
        function()
          vim.cmd([[execute('normal! ' . v:count1 . 'N')]])
          require('hlslens').start()
        end,
        silent = true,
      },
    },
  },

  {
    'haya14busa/vim-asterisk', -- non-lua plugin
    dependencies = {
      { 'kevinhwang91/nvim-hlslens' },
    },
    init = function()
      -- Keep cursor position across matches.
      vim.g['asterisk#keeppos'] = true
    end,
    keys = {
      { '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], mode = 'n', remap = true },
      { '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], mode = 'n', remap = true },
      { 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], mode = 'n', remap = true },
      { 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], mode = 'n', remap = true },
      { '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], mode = 'x', remap = true },
      { '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], mode = 'x', remap = true },
      { 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], mode = 'x', remap = true },
      { 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], mode = 'x', remap = true },
    },
  },
}
