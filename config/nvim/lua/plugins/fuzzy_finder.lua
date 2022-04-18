return {
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim'                       },
      { 'kyazdani42/nvim-web-devicons',    opt = true },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
      { 'neovim/nvim-lspconfig',           opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]', '<Nop>',       { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>u',    '[telescope]', {})

      vim.api.nvim_set_keymap('n', '[telescope]f', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]],  { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]g', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]],   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]*', [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]B', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],     { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]R', [[<Cmd>lua require('telescope.builtin').registers()<CR>]],   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]H', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]],   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]M', [[<Cmd>lua require('telescope.builtin').man_pages()<CR>]],   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]u', [[<Cmd>lua require('telescope.builtin').resume()<CR>]],      { noremap = true, silent = true })

      require('telescope').setup({
        defaults = {
          sorting_strategy = 'ascending',
          layout_strategy  = 'flex',

          layout_config = {
            prompt_position = 'top',
          },

          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<Esc>'] = 'close',
            },
          },
        },
      })
    end,
  },

  {
    'nvim-telescope/telescope-frecency.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'tami5/sqlite.lua'              },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]h', [[<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>]], { noremap = true, silent = true })

      require('telescope').load_extension('frecency')
    end,
  },

  {
    'folke/todo-comments.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim'         },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]t', ':<C-u>TodoTelescope<CR>', { noremap = true, silent = true })

      require('todo-comments').setup({})
    end,
  },

  {
    'nvim-telescope/telescope-packer.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'wbthomason/packer.nvim'        },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]p', [[<Cmd>lua require('telescope').extensions.packer.packer()<CR>]], { noremap = true, silent = true })

      require('telescope').load_extension('packer')
    end,
  },

  {
    'nvim-telescope/telescope-ghq.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]s', [[<Cmd>lua require('telescope').extensions.ghq.list()<CR>]], { noremap = true, silent = true })

      require('telescope').load_extension('ghq')
    end,
  },
}
