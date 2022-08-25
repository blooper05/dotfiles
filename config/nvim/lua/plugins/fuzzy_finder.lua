return {
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons',    opt = true },
      { 'neovim/nvim-lspconfig',           opt = true },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    config = function()
      vim.keymap.set('n', '[telescope]', '<Nop>',       {})
      vim.keymap.set('n', '<Space>u',    '[telescope]', { remap = true })

      vim.keymap.set('n', '[telescope]f', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]],  { silent = true })
      vim.keymap.set('n', '[telescope]g', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]],   { silent = true })
      vim.keymap.set('n', '[telescope]*', [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], { silent = true })
      vim.keymap.set('n', '[telescope]B', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],     { silent = true })
      vim.keymap.set('n', '[telescope]R', [[<Cmd>lua require('telescope.builtin').registers()<CR>]],   { silent = true })
      vim.keymap.set('n', '[telescope]H', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]],   { silent = true })
      vim.keymap.set('n', '[telescope]M', [[<Cmd>lua require('telescope.builtin').man_pages()<CR>]],   { silent = true })
      vim.keymap.set('n', '[telescope]u', [[<Cmd>lua require('telescope.builtin').resume()<CR>]],      { silent = true })

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
        pickers = {
          live_grep = {
            additional_args = function()
              return { '--hidden', '--glob=!.git/' }
            end,
          },

          grep_string = {
            additional_args = function()
              return { '--hidden', '--glob=!.git/' }
            end,
          },

          find_files = {
            find_command = { 'fd', '--type=file', '--hidden', '--exclude=.git/' },
          },
        },
      })
    end,
    event = 'VimEnter',
  },

  {
    'nvim-telescope/telescope-frecency.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'tami5/sqlite.lua'              },
    },
    config = function()
      vim.keymap.set('n', '[telescope]h', [[<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>]], { silent = true })

      require('telescope').load_extension('frecency')
    end,
    after = 'telescope.nvim',
  },

  {
    'nvim-telescope/telescope-packer.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'wbthomason/packer.nvim'        },
    },
    config = function()
      vim.keymap.set('n', '[telescope]p', [[<Cmd>lua require('telescope').extensions.packer.packer()<CR>]], { silent = true })

      require('telescope').load_extension('packer')
    end,
    after = 'telescope.nvim',
  },

  {
    'nvim-telescope/telescope-ghq.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.keymap.set('n', '[telescope]s', [[<Cmd>lua require('telescope').extensions.ghq.list()<CR>]], { silent = true })

      require('telescope').load_extension('ghq')
    end,
    after = 'telescope.nvim',
  },
}
