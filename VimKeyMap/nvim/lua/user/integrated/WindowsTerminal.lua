-- WindowsTerminal.lua
local M = {}

-- 定义一个函数来查找 Windows Terminal 的 settings.json 文件路径并打开它
function M.find_and_edit_terminal_settings()
  -- 使用 `io.popen` 调用 `where wt.exe` 获取路径
  local wt_path_handle = io.popen('where wt.exe 2>nul')
  if not wt_path_handle then
    print("Failed to execute command to find wt.exe.")
    return
  end

  local wt_path = wt_path_handle:read("*a"):gsub("\\", "/"):gsub("\n", "")
  wt_path_handle:close()

  -- 如果没有找到 wt.exe，wt_path 会是空的
  if wt_path == "" then
    print("wt.exe not found.")
    return
  end

  -- 提取用户目录
  local user_dir = wt_path:match("C:/Users/([^/]+)/")

  if user_dir then
    -- 构建 Microsoft.WindowsTerminalPreview 目录的位置
    local base_dir = string.format("C:/Users/%s/AppData/Local/Packages/", user_dir)
    local command = 'Get-ChildItem -Path "' .. base_dir .. '" -Filter "Microsoft.WindowsTerminalPreview*" -Directory | Select-Object -ExpandProperty FullName'

    local terminal_dir_handle = io.popen('pwsh -Command "' .. command .. '"')

    if not terminal_dir_handle then
      print("Failed to locate the Windows Terminal directory.")
      return
    end

    local terminal_dir = terminal_dir_handle:read("*a"):gsub("\n", "")
    terminal_dir_handle:close()

    if terminal_dir == "" then
      print("Microsoft.WindowsTerminalPreview directory not found.")
      return
    end

    -- 构建 settings.json 文件的完整路径
    local settings_path = terminal_dir .. "/LocalState/settings.json"

    -- 检查文件是否存在
    local file = io.open(settings_path, "r")
    if file then
      file:close()
      -- 编辑找到的 settings.json 文件
      vim.cmd("e " .. settings_path)
    else
      print("settings.json not found.")
    end
  else
    print("Could not determine user directory.")
  end
end

return M
