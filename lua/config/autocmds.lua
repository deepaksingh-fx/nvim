-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- autosave when leaving a buffer/window (other buffer, terminal, explorer...) or when nvim loses focus
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = vim.api.nvim_create_augroup("autosave", { clear = true }),
  callback = function(ev)
    local bo = vim.bo[ev.buf]
    if bo.modified and bo.modifiable and not bo.readonly and bo.buftype == "" and vim.api.nvim_buf_get_name(ev.buf) ~= "" then
      vim.api.nvim_buf_call(ev.buf, function()
        vim.cmd("silent update")
      end)
    end
  end,
})

-- lazygit needs plain j/k: the terminal-mode `jk` escape (better-escape) would break scrolling
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("lazygit_plain_jk", { clear = true }),
  pattern = "term://*lazygit*",
  callback = function(ev)
    for _, key in ipairs({ "j", "k" }) do
      vim.keymap.set("t", key, key, { buffer = ev.buf, nowait = true })
    end
  end,
})
