-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- carried over from the old config
map("n", ";", ":", { desc = "Command mode" })
map("n", "U", "<C-r>", { desc = "Redo" })
map("n", "<M-n>", function()
  Snacks.explorer()
end, { desc = "Explorer" })
map("n", "<leader>fg", LazyVim.pick("live_grep"), { desc = "Grep (Root Dir)" })
-- one terminal, shared by <C-/>, ,tb (bottom split) and ,tt (fullscreen).
-- Hiding keeps it running; reopening brings back the same shell.
local function term_opts()
  return { cwd = LazyVim.root() }
end

local function toggle_term()
  if Snacks.zen.win and Snacks.zen.win:valid() and vim.bo.buftype == "terminal" then
    Snacks.zen.zoom() -- leave fullscreen first
  end
  Snacks.terminal.focus(nil, term_opts())
end

map({ "n", "t" }, "<c-/>", toggle_term, { desc = "Terminal (Root Dir)" })
map({ "n", "t" }, "<c-_>", toggle_term, { desc = "which_key_ignore" })
map("n", "<leader>tb", toggle_term, { desc = "Terminal (bottom)" })
map("n", "<leader>tt", function()
  if Snacks.zen.win and Snacks.zen.win:valid() then
    -- leave fullscreen and hide the terminal (it keeps running)
    local zoomed_buf = Snacks.zen.win.buf
    Snacks.zen.zoom()
    for _, term in ipairs(Snacks.terminal.list()) do
      if term.buf == zoomed_buf then
        term:hide()
      end
    end
    return
  end
  local term, created = Snacks.terminal.get(nil, term_opts())
  if term and not created then
    term:show():focus()
  end
  Snacks.zen.zoom()
end, { desc = "Terminal (fullscreen)" })

map("n", "<leader>ct", function()
  require("config.themes").cycle()
end, { desc = "Cycle Theme" })
