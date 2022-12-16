return {
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim'                       },
      { 'nvim-tree/nvim-web-devicons',     opt = true },
      { 'neovim/nvim-lspconfig',           opt = true },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    setup = function()
      vim.keymap.set('n', '[telescope]', '<Nop>',       {})
      vim.keymap.set('n', '<Space>u',    '[telescope]', { remap = true })
    end,
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '[telescope]f', builtin.find_files,  { silent = true })
      vim.keymap.set('n', '[telescope]g', builtin.live_grep,   { silent = true })
      vim.keymap.set('n', '[telescope]*', builtin.grep_string, { silent = true })
      vim.keymap.set('n', '[telescope]B', builtin.buffers,     { silent = true })
      vim.keymap.set('n', '[telescope]R', builtin.registers,   { silent = true })
      vim.keymap.set('n', '[telescope]H', builtin.help_tags,   { silent = true })
      vim.keymap.set('n', '[telescope]M', builtin.man_pages,   { silent = true })
      vim.keymap.set('n', '[telescope]u', builtin.resume,      { silent = true })

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
              ['<C-a>'] = { '<Home>',  type = 'command' },
              ['<C-e>'] = { '<End>',   type = 'command' },
              ['<C-b>'] = { '<Left>',  type = 'command' },
              ['<C-f>'] = { '<Right>', type = 'command' },
              ['<C-d>'] = { '<Del>',   type = 'command' },
              ['<Esc>'] = 'close',
            },
          },
        },
        pickers = {
          live_grep = {
            additional_args = function() return { '--hidden', '--glob=!.git/' } end,
          },

          grep_string = {
            additional_args = function() return { '--hidden', '--glob=!.git/' } end,
          },

          find_files = {
            find_command = { 'fd', '--type=file', '--hidden', '--exclude=.git/' },
          },
        },
      })
    end,
    cmd = 'Telescope',
    keys = '[telescope]',
  },

  {
    'nvim-telescope/telescope-frecency.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'kkharji/sqlite.lua'            },
    },
    config = function()
      vim.keymap.set('n', '[telescope]h', require('telescope').extensions.frecency.frecency, { silent = true })
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
      vim.keymap.set('n', '[telescope]P', require('telescope').extensions.packer.packer, { silent = true })
    end,
    after = 'telescope.nvim',
  },

  {
    'nvim-telescope/telescope-ghq.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.keymap.set('n', '[telescope]s', require('telescope').extensions.ghq.list, { silent = true })
    end,
    after = 'telescope.nvim',
  },
}
