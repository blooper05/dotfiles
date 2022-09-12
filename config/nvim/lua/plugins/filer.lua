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

      vim.keymap.set('n', '[file]c', function() vim.cmd('Neotree toggle reveal') end, { silent = true })

      require('neo-tree').setup({
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      })
    end,
    event = 'BufReadPre',
  },

  {
    'ahmedkhalf/project.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim', opt = true },
    },
    config = function()
      local function telescopeProjects()
        local success, telescope = pcall(require, 'telescope')

        if success then telescope.extensions.projects.projects() end
      end

      vim.keymap.set('n', '[telescope]p', telescopeProjects, { silent = true })

      require('project_nvim').setup({
        sync_root_with_cwd  = true,
        respect_buf_cwd     = true,
        update_focused_file = {
          enable      = true,
          update_root = true,
        },
      })
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
