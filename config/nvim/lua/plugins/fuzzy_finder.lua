return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'flex',

        layout_config = {
          prompt_position = 'top',
        },

        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-a>'] = { '<Home>', type = 'command' },
            ['<C-e>'] = { '<End>', type = 'command' },
            ['<C-b>'] = { '<Left>', type = 'command' },
            ['<C-f>'] = { '<Right>', type = 'command' },
            ['<C-d>'] = { '<Del>', type = 'command' },
          },
        },
      },
      pickers = {
        live_grep = {
          additional_args = function()
            return { '--hidden', '--glob=!.git/', '--glob=!.terraform/' }
          end,
        },

        grep_string = {
          additional_args = function()
            return { '--hidden', '--glob=!.git/', '--glob=!.terraform/' }
          end,
        },

        find_files = {
          find_command = { 'fd', '--type=file', '--hidden', '--exclude=.git/', '--exclude=.terraform/' },
        },
      },
    },
    cmd = 'Telescope',
    keys = {
      { '[telescope]', '<Nop>' },
      { '<Space>u', '[telescope]', remap = true },

      -- stylua: ignore start
      { '[telescope]f', function() require('telescope.builtin').find_files() end,  silent = true },
      { '[telescope]g', function() require('telescope.builtin').live_grep() end,   silent = true },
      { '[telescope]*', function() require('telescope.builtin').grep_string() end, silent = true },
      { '[telescope]B', function() require('telescope.builtin').buffers() end,     silent = true },
      { '[telescope]R', function() require('telescope.builtin').registers() end,   silent = true },
      { '[telescope]H', function() require('telescope.builtin').help_tags() end,   silent = true },
      { '[telescope]M', function() require('telescope.builtin').man_pages() end,   silent = true },
      { '[telescope]u', function() require('telescope.builtin').resume() end,      silent = true },
      -- stylua: ignore end
    },
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })

      require('telescope').load_extension('ui-select')
    end,
    event = 'VeryLazy',
  },

  {
    'nvim-telescope/telescope-fzy-native.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('telescope').load_extension('fzy_native')
    end,
    event = 'VeryLazy',
  },

  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    keys = {
      -- stylua: ignore start
      { '[telescope]h', function() require('telescope').extensions.frecency.frecency() end, silent = true },
      -- stylua: ignore end
    },
  },

  {
    'nvim-telescope/telescope-ghq.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    keys = {
      -- stylua: ignore start
      { '[telescope]s', function() require('telescope').extensions.ghq.list() end, silent = true },
      -- stylua: ignore end
    },
  },
}
