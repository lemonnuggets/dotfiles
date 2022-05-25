-- lsp installer should be setup before lspconfig
require('plugins.lsp.nvim-lsp-installer-config')

local on_attach = require('keybindings.lsp.on-attach')
-- print(on_attach())
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end
require('plugins.lsp.sumneko-lua-config')
