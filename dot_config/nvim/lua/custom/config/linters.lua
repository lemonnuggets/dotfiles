local linters = {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  css = { 'stylelint' },
  python = { 'pylint', 'vulture' },
  json = { 'jsonlint' },
  lua = { 'selene' },
  sh = { 'shellcheck' },
  markdown = { 'markdownlint', 'vale' },
  yaml = { 'yamllint' },
  gitcommit = { 'write-good' },
}
for ft, _ in pairs(linters) do
  if not ft == 'markdown' then
    table.insert(linters[ft], 'codespell')
  end
  -- table.insert(linters[ft], 'woke')
  table.insert(linters[ft], 'editorconfig-checker')
end
return linters
