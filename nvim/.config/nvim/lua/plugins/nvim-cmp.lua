return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- LSP source
      'hrsh7th/cmp-buffer', -- Buffer source
      'hrsh7th/cmp-path', -- Filesystem paths source
      'hrsh7th/cmp-cmdline', -- Command-line source
      'L3MON4D3/LuaSnip', -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- LuaSnip completion source
      'rafamadriz/friendly-snippets', -- Preconfigured snippets
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- Load friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For LuaSnip snippet expansion
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
          ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Scroll docs down
          ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
          ['<C-e>'] = cmp.mapping.abort(), -- Close completion menu
          ['<CR>'] = cmp.mapping.confirm { select = false }, -- Confirm selection (only if explicitly selected)
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
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'buffer', priority = 500, keyword_length = 3 },
          { name = 'path', priority = 250 },
        },
        formatting = {
          format = function(entry, vim_item)
            -- Customize completion menu with source names
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = true, -- Show ghost text for completion preview
        },
      }

      -- Command-line completion for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Command-line completion for `:`
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = 'path' },
          { name = 'cmdline' },
        },
      })

      -- Set up LSP capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Example: Apply capabilities to your LSP servers
      -- require("lspconfig").<your_lsp_server>.setup { capabilities = capabilities }
    end,
  },
}
