-- [[ Configure LSP ]]
local on_attach = function(_, bufnr)
  --  This function gets run when an LSP connects to a particular buffer.
  local keymap = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  local nmap = function(keys, func, desc)
    keymap('n', keys, func, desc)
  end
  local nvmap = function(keys, func, desc)
    keymap({ 'n', 'v' }, keys, func, desc)
  end

  local builtin = require 'telescope.builtin'
  local buf = vim.lsp.buf

  nmap('<leader>cr', buf.rename, '[C]ode [R]ename')
  nvmap('<leader>ca', buf.code_action, '[C]ode [A]ction')

  nmap('<leader>cs', builtin.lsp_document_symbols, '[C]ode [S]ymbols')
  nmap('<leader>cd', builtin.lsp_type_definitions, '[C]ode Type [D]efinition')

  nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
  nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
  nmap('gD', buf.declaration, '[G]oto [D]eclaration')

  nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>wa', buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  nmap('K', buf.hover, 'Hover Documentation')
  nmap('<M-k>', buf.signature_help, 'Signature Documentation')
end

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Status updates for LSP
    'j-hui/fidget.nvim',
  },
  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    mason.setup {
      log_level = vim.log.levels.DEBUG,
    }
    mason_lspconfig.setup()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local language_servers = require 'config.language_servers'

    require('fidget').setup {}

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(language_servers),
    }

    local lspconfig = require 'lspconfig'
    mason_lspconfig.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = language_servers[server_name],
          filetypes = (language_servers[server_name] or {}).filetypes,
          handlers = (language_servers[server_name] or {}).handlers,
          init_options = (language_servers[server_name] or {}).init_options,
        }
      end,
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
