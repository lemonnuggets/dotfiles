return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdLineEnter' },
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'folke/lazydev.nvim',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- clojure cmp
    'PaterJason/cmp-conjure',

    -- icons
    'onsails/lspkind.nvim',
  },
  config = function()
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    local cmp = require 'cmp'

    -- `/` cmdline setup.
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
      enabled = function()
        -- Set of commands where cmp will be disabled
        local disabled = {
          IncRename = true,
        }
        -- Get first word of cmdline
        local cmd = vim.fn.getcmdline():match '%S+'

        return not disabled[cmd] or cmp.close()
      end,
    })

    local lspkind = require 'lspkind'
    local select_opts = { behavior = cmp.SelectBehavior.Select }
    cmp.setup {
      experimental = {
        ghost_text = true,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      completion = {
        completeopt = 'menu,menuone',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-y>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
        { name = 'conjure' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
      }, {
        { name = 'buffer', keyword_length = 3 },
      }),
      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = '󰌶',
            conjure = '󰘧',
            nvim_lsp_signature_help = '󰊕',
            luasnip = '',
            path = '',
            buffer = '',
            cmdline = '',
          }
          local menu_hl_group = {
            nvim_lsp = 'CmpItemMenuLSP',
            conjure = 'CmpItemMenuConjure',
            nvim_lsp_signature_help = 'CmpItemMenuSignature',
            luasnip = 'CmpItemMenuSnippet',
            path = 'CmpItemMenuPath',
            buffer = 'CmpItemMenuBuffer',
          }
          item.menu = menu_icon[entry.source.name] or string.format('%s', entry.source.name)

          item.menu_hl_group = menu_hl_group[entry.source.name] or 'CmpItemMenu'

          --- Adaptive Fixed Width (https://github.com/hrsh7th/nvim-cmp/discussions/609#discussioncomment-5727678) ---

          -- Set the fixed width of the completion menu to 60 characters.
          -- fixed_width = 20

          -- Set 'fixed_width' to false if not provided.
          fixed_width = fixed_width or false

          local label = item.abbr

          if fixed_width then
            vim.o.pumwidth = fixed_width
          end
          local win_width = vim.api.nvim_win_get_width(0)
          local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)
          if #label > max_content_width then
            item.abbr = vim.fn.strcharpart(label, 0, max_content_width - 3) .. '...'
          else
            item.abbr = label .. (' '):rep(max_content_width - #label)
          end

          item.kind_symbol = (lspkind.symbolic or lspkind.get_symbol)(item.kind)
          item.kind = ' ' .. item.kind_symbol .. ' ' .. item.kind
          return item
        end,
      },
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
