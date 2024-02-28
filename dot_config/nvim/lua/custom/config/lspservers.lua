local lspservers = {
  -- rust_analyzer = {},
  clangd = {},
  gopls = {},
  pyright = {},
  tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  clojure_lsp = {
    init_options = {
      -- using zprint from conform instead
      ['document-formatting?'] = false,
      ['document-range-formatting?'] = false,
    },
  },
  jsonls = {
    json = {
      validate = { enable = true },
      schemas = require('schemastore').json.schemas {
        extras = {
          {
            name = '.luarc.json',
            description = 'setting of sumneko lua',
            fileMatch = { '.luarc.json' },
            url = 'https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json',
          },
        },
      },
    },
  },
  yamlls = {
    yaml = {
      validate = true,
      -- disable the schema store
      schemaStore = {
        enable = false,
        url = '',
      },
      -- manually select schemas
      schemas = require('schemastore').yaml.schemas {},
    },
  },
  theme_check = {
    filetypes = { 'liquid' },
  },
  marksman = {},
  lua_ls = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        disable = {
          'missing-fields',
        },
        globals = {
          'vim',
        },
      },
    },
  },
}
return lspservers
