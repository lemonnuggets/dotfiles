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
    marksman = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { 'missing-fields' } },
        },
    },
}
return lspservers
