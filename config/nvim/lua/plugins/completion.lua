return {
  {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'neovim/nvim-lspconfig'    },
      { 'L3MON4D3/LuaSnip'         },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-buffer'       },
      { 'hrsh7th/cmp-calc'         },
      { 'hrsh7th/cmp-cmdline'      },
      { 'hrsh7th/cmp-emoji'        },
      { 'hrsh7th/cmp-nvim-lsp'     },
      { 'hrsh7th/cmp-nvim-lua'     },
      { 'hrsh7th/cmp-path'         },
      { 'onsails/lspkind-nvim'     },
      { 'f3fora/cmp-spell'         },
      { 'uga-rosa/cmp-dictionary'  },
      { 'ray-x/cmp-treesitter'     },
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

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
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
          { name = 'calc'       },
          { name = 'dictionary' },
          { name = 'spell'      },
          { name = 'treesitter' },
        }),
        formatting = {
          format = require('lspkind').cmp_format({
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
      })

      cmp.setup.filetype({ 'gina-commit', 'gitcommit', 'markdown' }, {
        sources = cmp.config.sources({
          { name = 'emoji'    },
          { name = 'luasnip'  },
          { name = 'nvim_lsp' },
          { name = 'path'     },
        }, {
          { name = 'buffer'     },
          { name = 'calc'       },
          { name = 'dictionary' },
          { name = 'spell'      },
          { name = 'treesitter' },
        }),
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })

      -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup({
      --   capabilities = capabilities,
      -- })
    end,
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

  {
    'windwp/nvim-autopairs',
    config = function()
      local autopairs = require('nvim-autopairs')
      local rule = require('nvim-autopairs.rule')

      autopairs.setup({})

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
  },
}
