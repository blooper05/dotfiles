return {
  {
    'kevinhwang91/nvim-hlslens',
    opts = {
      calm_down = true,
    },
    keys = {
      {
        'n',
        function()
          vim.cmd([[
            try
              execute('normal! ' . v:count1 . 'n')
              lua require('hlslens').start()
            catch /^Vim(normal):E486: Pattern not found: /
              echo 'Pattern not found'
            endtry
          ]])
        end,
        silent = true,
      },
      {
        'N',
        function()
          vim.cmd([[
            try
              execute('normal! ' . v:count1 . 'N')
              lua require('hlslens').start()
            catch /^Vim(normal):E486: Pattern not found: /
              echo 'Pattern not found'
            endtry
          ]])
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
      { '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x' }, remap = true },
      { '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x' }, remap = true },
      { 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x' }, remap = true },
      { 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x' }, remap = true },
    },
  },
}
