return {
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'Exafunction/codeium.nvim' },
      { 'Kaiser-Yang/blink-cmp-dictionary' },
      { 'L3MON4D3/LuaSnip' },
      { 'f3fora/cmp-spell' },
      { 'moyiz/blink-emoji.nvim' },
      { 'saghen/blink.compat' },
    },
    version = '*',
    init = function()
      -- Set completeopt to have a better completion experience.
      vim.opt.completeopt = {
        'menuone',
        'noselect',
      }

      -- Avoid showing extra message when using completion.
      vim.opt.shortmess:append('c')
    end,
    opts = {
      keymap = { preset = 'enter' },

      snippets = { preset = 'luasnip' },

      completion = {
        list = { selection = { preselect = false } },

        menu = {
          border = 'rounded',
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', gap = 1 }, { 'source_name' } },
          },
        },
        documentation = { auto_show = true, window = { border = 'rounded' } },
      },
      signature = { enabled = true, window = { border = 'rounded' } },

      sources = {
        default = { 'snippets', 'lsp', 'path', 'codeium', 'buffer' },
        per_filetype = {
          gitcommit = { 'snippets', 'lsp', 'path', 'emoji', 'codeium', 'buffer', 'dictionary', 'spell' },
          ['gina-commit'] = { 'snippets', 'lsp', 'path', 'emoji', 'codeium', 'buffer', 'dictionary', 'spell' },
          markdown = { 'snippets', 'lsp', 'path', 'emoji', 'codeium', 'buffer', 'dictionary', 'spell' },
        },
        providers = {
          emoji = { module = 'blink-emoji', name = 'Emoji' },
          codeium = { module = 'blink.compat.source', name = 'Codeium', async = true, opts = { cmp_name = 'codeium' } },
          dictionary = {
            module = 'blink-cmp-dictionary',
            name = 'Dict',
            min_keyword_length = 3,
            opts = {
              dictionary_files = { '/usr/share/dict/words' },
              get_command = 'sk',
              get_command_args = function(prefix, _)
                return { '--filter=' .. prefix, '--sync', '--no-sort', '-i' }
              end,
            },
          },
          spell = { module = 'blink.compat.source', name = 'Spell', opts = { cmp_name = 'spell' } },
        },
      },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
  },

  {
    'Kaiser-Yang/blink-cmp-dictionary',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    init = function()
      vim.opt.spelllang = { 'en_us' }
    end,
  },

  {
    'f3fora/cmp-spell',
    dependencies = {
      { 'psliwka/vim-dirtytalk' }, -- non-lua plugin
    },
    init = function()
      vim.opt.spelllang = { 'en_us' }

      vim.api.nvim_create_user_command('SpellCheckingToggle', function()
        vim.opt.spell = not vim.api.nvim_get_option_value('spell', { win = 0 })
      end, { force = true })
    end,
  },

  {
    'psliwka/vim-dirtytalk', -- non-lua plugin
    build = ':DirtytalkUpdate',
    init = function()
      vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site')

      vim.opt.spelllang:append('programming')
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
    end,
  },

  {
    'altermo/ultimate-autopair.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
  },

  {
    'danymat/neogen',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      snippet_engine = 'luasnip',
    },
    cmd = 'Neogen',
    keys = {
      -- stylua: ignore start
      { 'gcd', function() require('neogen').generate() end, silent = true },
      -- stylua: ignore end
    },
  },
}
