local events = {}
local event_count = 0
function add_event(e)
  event_count = event_count + 1
  events[event_count] = e
end

vim.api.nvim_create_user_command('ShowEvents', function()
  local timestamp = os.date '%Y-%m-%d_%H-%M-%S'
  local log_file_name = 'conjure-events_' .. timestamp .. '.log'
  local log_file = io.open(log_file_name, 'a')
  if log_file then
    log_file:write('count: ' .. event_count .. '\n')
    log_file:write(vim.inspect(events) .. '\n')
    log_file:close()
  else
    vim.print 'Error: Could not open log file'
  end
end, { desc = 'show events executed' })

vim.api.nvim_create_autocmd({
  ---------- Conjure Events ----------
  'DirChanged',
  'VimLeavePre',
  'FileType',
  'BufEnter',
  'User',

  -- 'BufNewFile', 'BufReadPre', 'BufRead', 'BufReadPost', 'FileReadPre', 'FileReadPost', 'FilterReadPre', 'FilterReadPost', 'StdinReadPre', 'StdinReadPost', 'BufWrite', 'BufWritePre', 'BufWritePost', 'FileWritePre', 'FileWritePost', 'FileAppendPre', 'FileAppendPost', 'FilterWritePre', 'FilterWritePost', 'BufAdd', 'BufCreate', 'BufDelete', 'BufWipeout', 'BufFilePre', 'BufFilePost', 'BufEnter', 'BufLeave', 'BufWinEnter', 'BufWinLeave', 'BufUnload', 'BufHidden', 'BufNew', 'SwapExists', 'FileType', 'Syntax', 'EncodingChanged', 'TermChanged', 'VimEnter', 'GUIEnter', 'GUIFailed', 'TermResponse', 'QuitPre', 'VimLeavePre', 'VimLeave', 'FileChangedShell', 'FileChangedShellPost', 'FileChangedRO', 'ShellCmdPost', 'ShellFilterPost', 'CmdUndefined', 'SpellFileMissing', 'SourcePre', 'VimResized', 'FocusGained', 'FocusLost', 'CursorHold', 'CursorHoldI', 'CursorMoved', 'CursorMovedI', 'WinEnter', 'WinLeave', 'TabEnter', 'TabLeave', 'CmdwinEnter', 'CmdwinLeave', 'InsertEnter', 'InsertChange', 'InsertLeave', 'InsertCharPre', 'TextChanged', 'TextChangedI', 'ColorScheme', 'RemoteReply', 'QuickFixCmdPre', 'QuickFixCmdPost', 'SessionLoadPost', 'MenuPopup', 'CompleteDone', 'User',
}, {
  desc = 'Collect events',
  group = vim.api.nvim_create_augroup('collect_events', { clear = true }),
  callback = function(e)
    event = e.event or '<nil>'
    file = e.file or '<nil>'
    data = e.data or '<nil>'
    if event == 'User' then
      if data ~= 'conjure' then
        return
      end
    end
    -- vim.notify('Event: ' .. event .. '\nFile: ' .. file, vim.log.levels.INFO)
    add_event(e)
  end,
})
