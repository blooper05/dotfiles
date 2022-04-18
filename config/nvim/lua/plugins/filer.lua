return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim'                     },
      { 'nvim-lua/plenary.nvim'                    },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[file]',   '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>f', '[file]', {})

      vim.api.nvim_set_keymap('n', '[file]c', ':<C-u>NeoTreeRevealToggle<CR>', { noremap = true, silent = true })

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('neo-tree').setup({
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      })
    end,
  },

  {
    'ahmedkhalf/project.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('project_nvim').setup({})

      require('telescope').load_extension('projects')
    end,
  },
}
