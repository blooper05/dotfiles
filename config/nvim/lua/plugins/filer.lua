return {
  {
    'nvim-tree/nvim-tree.lua',
    requires = {
      { 'ahmedkhalf/project.nvim', opt = true },
      { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    setup = function()
      -- Avoid loading the plugin and the autoload portions of netrw.
      vim.g.loaded_netrw = false
      vim.g.loaded_netrwPlugin = false

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      vim.keymap.set('n', '[file]', '<Nop>', {})
      vim.keymap.set('n', '<Space>f', '[file]', { remap = true })
    end,
    config = function()
      vim.keymap.set('n', '[file]c', function()
        vim.cmd('NvimTreeToggle')
      end, { silent = true })

      require('nvim-tree').setup({
        view = {
          adaptive_size = true,
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
    end,
    cmd = 'NvimTree',
    keys = '[file]',
  },

  {
    'ahmedkhalf/project.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim', opt = true },
    },
    setup = function()
      vim.keymap.set('n', '[telescope]p', function()
        require('telescope').extensions.projects.projects()
      end, { silent = true })
    end,
    config = function()
      require('project_nvim').setup({})
    end,
    event = 'BufReadPre',
  },

  {
    'lambdalisue/suda.vim', -- non-lua plugin
    setup = function()
      -- Automatically switch a buffer name when the target file is not readable or writable.
      vim.g.suda_smart_edit = true
    end,
    event = 'BufReadPre',
  },
}
