return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      { 'ahmedkhalf/project.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    init = function()
      -- Avoid loading the plugin and the autoload portions of netrw.
      vim.g.loaded_netrw = false
      vim.g.loaded_netrwPlugin = false

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true
    end,
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    },
    cmd = 'NvimTree',
    keys = {
      { '[file]', '<Nop>' },
      { '<Space>f', '[file]', remap = true },

      -- stylua: ignore start
      { '[file]c',  function() require('nvim-tree.api').tree.toggle() end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'ahmedkhalf/project.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    event = 'BufReadPost',
    keys = {
      -- stylua: ignore start
      { '[telescope]p', function() require('telescope').extensions.projects.projects() end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'lambdalisue/suda.vim', -- non-lua plugin
    init = function()
      -- Automatically switch a buffer name when the target file is not readable or writable.
      vim.g.suda_smart_edit = true
    end,
    event = 'BufReadPost',
  },
}
