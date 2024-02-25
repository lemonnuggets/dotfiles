-- based on https://github.com/chrisgrieser/.config/blob/7dc36c350976010b32ece078edd581687634811a/nvim/lua/plugins/linter-formatter.lua#L27-L82
local linters = require 'custom.config.linters'
local debuggers = require 'custom.config.debuggers'
local formatters = require 'custom.config.formatters'
local lspservers = require 'custom.config.lspservers'
local dontInstall = {
  -- not real formatters, but pseudo-formatters from conform.nvim
  'trim_whitespace',
  'trim_newlines',
  'squeeze_blanks',
  'injected',
}
local substitutions = {
  ['write_good'] = 'write-good',
}

---given the linter- and formatter-list of nvim-lint and conform.nvim, extract a
---list of all tools that need to be auto-installed
local function toolsToAutoinstall(myLinters, myFormatters, myDebuggers, ignoreTools)
  -- get all linters, formatters, & debuggers and merge them into one list
  local linterList = vim.tbl_flatten(vim.tbl_values(myLinters))
  local formatterList = vim.tbl_flatten(vim.tbl_values(myFormatters))
  local tools = vim.list_extend(linterList, formatterList)
  vim.list_extend(tools, myDebuggers)

  -- only unique tools
  table.sort(tools)
  tools = vim.fn.uniq(tools)

  -- remove exceptions not to install
  tools = vim.tbl_filter(function(tool)
    return not vim.tbl_contains(ignoreTools, tool)
  end, tools)
  return tools
end

-- Function to replace entries in a table based on substitution rules defined in a substitution table
local function applySubstitutions(tbl, substitutions)
  for i, v in ipairs(tbl) do
    local replacement = substitutions[v]
    if replacement then
      tbl[i] = replacement
    end
  end
end

return {
  -- auto-install missing linters & formatters
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local myTools = toolsToAutoinstall(linters, formatters, debuggers, dontInstall)
    vim.list_extend(myTools, vim.tbl_keys(lspservers))
    applySubstitutions(myTools, substitutions)

    require('mason-tool-installer').setup {
      ensure_installed = myTools,
      run_on_start = false, -- triggered manually, since not working with lazy-loading
    }

    -- clean unused & install missing
    vim.defer_fn(vim.cmd.MasonToolsInstall, 500)
    vim.defer_fn(vim.cmd.MasonToolsClean, 1000) -- delayed, so noice.nvim is loaded before
  end,
}
