return {
  {
    'pwntester/octo.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    cmd = 'Octo',
    keys = {
      { '[octo]', '<Nop>' },
      { '[telescope]G', '[octo]', remap = true },

      {
        '[octo]i',
        function()
          vim.cmd('Octo issue list')
        end,
        silent = true,
      },
      {
        '[octo]p',
        function()
          vim.cmd('Octo pr list')
        end,
        silent = true,
      },
    },
  },

  {
    'jackMort/ChatGPT.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
      keymaps = {
        scroll_up = false,
        scroll_down = false,
      },
    },
    cmd = 'ChatGPT',
  },

  {
    'jcdickinson/codeium.nvim',
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
      { 'jcdickinson/http.nvim', build = 'cargo build --workspace --release' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = true,
    cmd = 'Codeium',
  },
}
