return {
  -- Claude Code: open as a right-hand vertical split taking half the screen
  {
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        split_side = "right",
        split_width_percentage = 0.5,
      },
    },
  },
}
