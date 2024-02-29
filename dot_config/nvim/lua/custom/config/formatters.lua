local formatters = {
  javascript = { { 'prettierd', 'prettier' } },
  typescript = { { 'prettierd', 'prettier' } },
  javascriptreact = { { 'prettierd', 'prettier' } },
  typescriptreact = { { 'prettierd', 'prettier' } },
  json = { { 'prettierd', 'prettier' } },
  jsonc = { { 'prettierd', 'prettier' } },
  yaml = { { 'prettierd', 'prettier' } },
  html = { { 'prettierd', 'prettier' } },
  css = { { 'prettierd', 'prettier' } },
  python = { 'black' },
  clojure = { 'joker' },
  lua = { 'stylua' },
  markdown = { { 'prettierd', 'prettier' } },
  sh = { 'shellcheck', 'shfmt' },
  ['_'] = { 'trim_whitespace', 'trim_newlines', 'squeeze_blanks' },
}
return formatters
