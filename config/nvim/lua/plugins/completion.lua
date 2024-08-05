return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'Exafunction/codeium.nvim' },
      { 'VonHeikemen/lsp-zero.nvim' },
      { 'f3fora/cmp-spell' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'neovim/nvim-lspconfig' },
      { 'onsails/lspkind-nvim' },
      { 'ray-x/cmp-treesitter' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'uga-rosa/cmp-dictionary' },
      { 'uga-rosa/cmp-dynamic' },
    },
    init = function()
      -- Set completeopt to have a better completion experience.
      vim.opt.completeopt = {
        'menuone',
        'noselect',
      }

      -- Avoid showing extra message when using completion.
      vim.opt.shortmess:append('c')
    end,
    config = function()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-8),
          ['<C-f>'] = cmp.mapping.scroll_docs(8),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lua' },
          { name = 'path' },
          { name = 'codeium' },
        }, {
          { name = 'buffer' },
          { name = 'treesitter' },
          { name = 'dynamic' },
          { name = 'dictionary' },
          { name = 'spell' },
          { name = 'calc' },
        }),
        formatting = {
          format = lspkind.cmp_format({
            menu = {
              buffer = '[Buffer]',
              calc = '[Calc]',
              cmdline = '[Cmd]',
              codeium = '[Codeium]',
              dictionary = '[Dictionary]',
              dynamic = '[Dynamic]',
              emoji = '[Emoji]',
              luasnip = '[Snippet]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[Lua]',
              path = '[Path]',
              spell = '[Spell]',
              treesitter = '[TS]',
            },
            symbol_map = {
              Codeium = '',
            },
          }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      cmp.setup.filetype({ 'gitcommit', 'markdown' }, {
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          { name = 'emoji' },
          { name = 'codeium' },
        }, {
          { name = 'buffer' },
          { name = 'treesitter' },
          { name = 'dynamic' },
          { name = 'dictionary' },
          { name = 'spell' },
          { name = 'calc' },
        }),
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline({
          ['<C-n>'] = cmp.config.disable,
          ['<C-p>'] = cmp.config.disable,
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbol' },
        }, {
          { name = 'buffer' },
        }),
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ['<C-n>'] = cmp.config.disable,
          ['<C-p>'] = cmp.config.disable,
        }),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
    event = { 'InsertEnter', 'CmdlineEnter' },
  },

  {
    'uga-rosa/cmp-dynamic',
    config = function()
      require('cmp_dynamic').register({
        {
          label = 'today',
          insertText = function()
            return os.date('%Y/%m/%d')
          end,
        },
      })
    end,
  },

  {
    'uga-rosa/cmp-dictionary',
    init = function()
      vim.opt.spelllang = { 'en_us' }
    end,
    opts = {
      paths = { '/usr/share/dict/words' },
    },
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
