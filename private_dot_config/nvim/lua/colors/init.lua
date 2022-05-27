local colorscheme = "dracula"

local status_color_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
local status_notify_ok, notify = pcall(require, "notify")
vim.notify = notify
if not status_color_ok then
    local message = "colorscheme " ..  colorscheme .. " not found!"
    if status_notify_ok then
        vim.notify(message)
        return
    else
        print(message)
    end
end
