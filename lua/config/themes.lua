-- Theme cycling with persistence. The last colorscheme you pick (via cycling or
-- <leader>uC) is saved and restored on the next start.
local M = {}

M.themes = {
  "catppuccin",
  "tokyonight-night",
  "kanagawa",
  "rose-pine",
  "gruvbox-material",
  "nightfox",
  "vscode",
  "ayu-dark",
}

M.default = "catppuccin"

local state_file = vim.fn.stdpath("state") .. "/last_colorscheme"

local function read_last()
  local f = io.open(state_file, "r")
  if not f then
    return nil
  end
  local name = f:read("*l")
  f:close()
  return name
end

function M.load()
  local last = read_last()
  if not (last and pcall(vim.cmd.colorscheme, last)) then
    vim.cmd.colorscheme(M.default)
  end

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("persist_colorscheme", { clear = true }),
    callback = function(ev)
      local f = io.open(state_file, "w")
      if f then
        f:write(ev.match)
        f:close()
      end
    end,
  })
end

function M.cycle()
  local current = vim.g.colors_name
  local idx = 0
  for i, name in ipairs(M.themes) do
    if name == current or vim.startswith(current or "", name) then
      idx = i
      break
    end
  end
  local next_theme = M.themes[idx % #M.themes + 1]
  if pcall(vim.cmd.colorscheme, next_theme) then
    vim.notify("Theme → " .. next_theme)
  else
    vim.notify("Failed to load theme: " .. next_theme, vim.log.levels.WARN)
  end
end

return M
