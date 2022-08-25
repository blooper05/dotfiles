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
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>']  = cmp.mapping.confirm({ select = true }),

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

      local luasnip = require('luasnip')
      local s       = luasnip.snippet
      local i       = luasnip.insert_node
      local fmt     = require('luasnip.extras.fmt').fmt

      luasnip.add_snippets('gina-commit', {
        s('sparkles',            fmt('✨ feat({}): ',     { i(1, 'scope') })),
        s('bug',                 fmt('🐛 fix({}): ',      { i(1, 'scope') })),
        s('ambulance',           fmt('🚑 fix({}): ',      { i(1, 'scope') })),
        s('lock',                fmt('🔒 fix({}): ',      { i(1, 'scope') })),
        s('pencil2',             fmt('✏️ fix({}): ',       { i(1, 'scope') })),
        s('recycle',             fmt('♻️ refactor({}): ',  { i(1, 'scope') })),
        s('truck',               fmt('🚚 refactor({}): ', { i(1, 'scope') })),
        s('fire',                fmt('🔥 refactor({}): ', { i(1, 'scope') })),
        s('art',                 fmt('🎨 style({}): ',    { i(1, 'scope') })),
        s('rotating_light',      fmt('🚨 style({}): ',    { i(1, 'scope') })),
        s('zap',                 fmt('⚡️ perf({}): ',     { i(1, 'scope') })),
        s('white_check_mark',    fmt('✅ test({}): ',     { i(1, 'scope') })),
        s('memo',                fmt('📝 docs({}): ',     { i(1, 'scope') })),
        s('bulb',                fmt('💡 docs({}): ',     { i(1, 'scope') })),
        s('green_heart',         fmt('💚 ci({}): ',       { i(1, 'scope') })),
        s('construction_worker', fmt('👷 ci({}): ',       { i(1, 'scope') })),
        s('tada',                fmt('🎉 chore({}): ',    { i(1, 'scope') })),
        s('bookmark',            fmt('🔖 chore({}): ',    { i(1, 'scope') })),
        s('rocket',              fmt('🚀 chore({}): ',    { i(1, 'scope') })),
        s('wrench',              fmt('🔧 chore({}): ',    { i(1, 'scope') })),
        s('hammer',              fmt('🔨 chore({}): ',    { i(1, 'scope') })),
        s('heavy_plus_sign',     fmt('➕ chore({}): ',    { i(1, 'scope') })),
        s('heavy_minus_sign',    fmt('➖ chore({}): ',    { i(1, 'scope') })),
        s('arrow_up',            fmt('⬆️ chore({}): ',     { i(1, 'scope') })),
        s('arrow_down',          fmt('⬇️ chore({}): ',     { i(1, 'scope') })),
      })
    end,
    event = 'VimEnter',
    after = 'friendly-snippets',
  },

  { 'saadparwaiz1/cmp_luasnip',             requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp',                 requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp-document-symbol', requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-buffer',                   requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'ray-x/cmp-treesitter',                 requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },

  {
    'f3fora/cmp-spell',
    requires = {
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      vim.api.nvim_create_user_command('SpellCheckingOn',  'setlocal spell spelllang=en_us', { force = true })
      vim.api.nvim_create_user_command('SpellCheckingOff', 'setlocal nospell',               { force = true })
    end,
    after = 'nvim-cmp',
  },

  {
    'uga-rosa/cmp-dictionary',
    requires = {
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      require('cmp_dictionary').setup({
        dic = {
          ['*'] = { '/usr/share/dict/words' },
        },
      })
    end,
    after = 'nvim-cmp',
  },

  { 'hrsh7th/cmp-nvim-lua', requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-cmdline',  requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-path',     requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-calc',     requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-emoji',    requires = 'hrsh7th/nvim-cmp', after = 'nvim-cmp' },

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
