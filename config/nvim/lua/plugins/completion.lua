return {
  {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'L3MON4D3/LuaSnip'      },
      { 'onsails/lspkind-nvim'  },
    },
    config = function()
      -- Set completeopt to have a better completion experience.
      vim.opt.completeopt = {
        'menuone',
        'noselect',
      }

      -- Avoid showing message extra message when using completion.
      vim.opt.shortmess:append('c')

      local cmp     = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format({
            menu = {
              buffer     = '[Buffer]',
              calc       = '[Calc]',
              cmdline    = '[Cmd]',
              dictionary = '[Dictionary]',
              emoji      = '[Emoji]',
              luasnip    = '[Snippet]',
              nvim_lsp   = '[LSP]',
              nvim_lua   = '[Lua]',
              path       = '[Path]',
              spell      = '[Spell]',
              treesitter = '[TS]',
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>']     = cmp.mapping.scroll_docs(-4),
          ['<C-f>']     = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>']     = cmp.mapping.abort(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'luasnip'  },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'path'     },
        }, {
          { name = 'buffer'     },
          { name = 'treesitter' },
          { name = 'spell'      },
          { name = 'dictionary' },
          { name = 'calc'       },
        }),
      })

      cmp.setup.filetype({ 'gina-commit', 'gitcommit', 'markdown' }, {
        sources = cmp.config.sources({
          { name = 'luasnip'  },
          { name = 'nvim_lsp' },
          { name = 'path'     },
          { name = 'emoji'    },
        }, {
          { name = 'buffer'     },
          { name = 'treesitter' },
          { name = 'spell'      },
          { name = 'dictionary' },
          { name = 'calc'       },
        }),
      })

      cmp.setup.cmdline('/', {
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
    after = { 'LuaSnip', 'lspkind-nvim' },
  },

  {
    'L3MON4D3/LuaSnip',
    requires = {
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
    event = 'VimEnter',
    after = 'friendly-snippets',
  },

  { 'saadparwaiz1/cmp_luasnip',             after = 'nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp',                 after = 'nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-buffer',                   after = 'nvim-cmp' },
  { 'ray-x/cmp-treesitter',                 after = 'nvim-cmp' },

  {
    'f3fora/cmp-spell',
    config = function()
      vim.api.nvim_create_user_command('SpellCheckingOn',  'setlocal spell spelllang=en_us', { force = true })
      vim.api.nvim_create_user_command('SpellCheckingOff', 'setlocal nospell',               { force = true })
    end,
    after = 'nvim-cmp',
  },

  {
    'uga-rosa/cmp-dictionary',
    config = function()
      require('cmp_dictionary').setup({
        dic = {
          ['*'] = { '/usr/share/dict/words' },
        },
      })
    end,
    after = 'nvim-cmp',
  },

  { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-cmdline',  after = 'nvim-cmp' },
  { 'hrsh7th/cmp-path',     after = 'nvim-cmp' },
  { 'hrsh7th/cmp-calc',     after = 'nvim-cmp' },
  { 'hrsh7th/cmp-emoji',    after = 'nvim-cmp' },

  {
    'windwp/nvim-autopairs',
    requires = {
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    config = function()
      local autopairs = require('nvim-autopairs')
      local rule = require('nvim-autopairs.rule')

      autopairs.setup({
        check_ts = true,
      })

      autopairs.add_rules({
        rule(' ', ' '):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),

        rule('( ', ' )')
          :with_pair(function() return false end)
          :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
          end)
          :use_key(')'),

        rule('{ ', ' }')
          :with_pair(function() return false end)
          :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
          end)
          :use_key('}'),

        rule('[ ', ' ]')
          :with_pair(function() return false end)
          :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
          end)
          :use_key(']'),
      })
    end,
    event = 'VimEnter',
  },
}
