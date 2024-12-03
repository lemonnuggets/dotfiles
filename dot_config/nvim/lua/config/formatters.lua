local formatters = {
  javascript = { 'prettierd', 'prettier', stop_after_first = true },
  typescript = { 'prettierd', 'prettier', stop_after_first = true },
  javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
  typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
  json = { 'prettierd', 'prettier', stop_after_first = true },
  jsonc = { 'prettierd', 'prettier', stop_after_first = true },
  yaml = { 'prettierd', 'prettier', stop_after_first = true },
  html = { 'prettierd', 'prettier', stop_after_first = true },
  css = { 'prettierd', 'prettier', stop_after_first = true },
  python = { 'black' },
  clojure = { 'zprint' },
  lua = { 'stylua' },
  markdown = { 'prettierd', 'prettier', stop_after_first = true },
  sh = { 'shellcheck', 'shfmt' },
  -- xml = { 'xmlformat' },
  ['_'] = { 'trim_whitespace', 'trim_newlines', 'squeeze_blanks' },
}
return formatters
