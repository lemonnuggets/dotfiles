-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

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
    -- Return true if cmd isn't disabled
    -- else call/return cmp.close(), which returns false
    return not disabled[cmd] or cmp.close()
  end,
})

local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
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
    completeopt = 'menu,menuone,preview,noinsert,noselect',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'conjure' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 3 },
  }),
  formatting = {
    fields = { 'abbr', 'menu', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        conjure = '🔮',
        nvim_lsp = '💡',
        nvim_lsp_signature_help = '📝',
        luasnip = '🌟',
        buffer = '📄',
        path = '📁',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
