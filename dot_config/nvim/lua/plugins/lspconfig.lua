-- [[ Configure LSP ]]
local on_attach = function(args)
  local bufnr = args.buf
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

  nmap('gd', buf.definition, '[G]oto [D]efinition')
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

  -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
  ---@param client vim.lsp.Client
  ---@param method vim.lsp.protocol.Method
  ---@param bufnr? integer some lsp support methods only in specific files
  ---@return boolean
  local function client_supports_method(client, method, bufnr)
    if vim.fn.has 'nvim-0.11' == 1 then
      return client:supports_method(method, bufnr)
    else
      return client.supports_method(method, { bufnr = bufnr })
    end
  end

  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  -- When you move your cursor, the highlights will be cleared (the second autocommand).
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
      end,
    })
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = on_attach,
})

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'mason-org/mason.nvim',
      opts = {
        log_level = vim.log.levels.DEBUG,
      },
    },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Status updates for LSP
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local language_servers = require 'config.language_servers'

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    --
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local mason_lspconfig = require 'mason-lspconfig'
    local lspconfig = require 'lspconfig'
    mason_lspconfig.setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = language_servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          lspconfig[server_name].setup {
            capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
            on_attach = on_attach,
            settings = server,
            filetypes = (server or {}).filetypes,
            handlers = (server or {}).handlers,
            init_options = (server or {}).init_options,
          }
        end,
      },
    }

    -- mason_lspconfig.setup_handlers {
    --   function(server_name)
    --     print('handler', server_name)
    --     lspconfig[server_name].setup {
    --       capabilities = capabilities,
    --       on_attach = on_attach,
    --       settings = language_servers[server_name],
    --       filetypes = (language_servers[server_name] or {}).filetypes,
    --       handlers = (language_servers[server_name] or {}).handlers,
    --       init_options = (language_servers[server_name] or {}).init_options,
    --     }
    --   end,
    -- }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
