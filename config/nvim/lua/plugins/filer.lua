return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim'                     },
      { 'nvim-lua/plenary.nvim'                    },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.keymap.set('n', '[file]',   '<Nop>',  {})
      vim.keymap.set('n', '<Space>f', '[file]', { remap = true })

      vim.keymap.set('n', '[file]c', '<Cmd>Neotree toggle reveal<CR>', { silent = true })

      require('neo-tree').setup({
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      })
    end,
    event = 'VimEnter',
  },

  {
    'ahmedkhalf/project.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim', opt = true },
    },
    config = function()
      require('project_nvim').setup({})

      require('telescope').load_extension('projects')
    end,
    event = 'VimEnter',
  },
}
