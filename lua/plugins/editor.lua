return {
  -- file explorer on the right, showing dotfiles (like the old nvim-tree setup)
  {
    "folke/snacks.nvim",
    opts = {
      -- <C-/> inside the terminal is handled by the global mapping in config/keymaps.lua,
      -- which also exits fullscreen (,tt) before hiding
      terminal = {
        win = {
          keys = {
            hide_slash = false,
            hide_underscore = false,
          },
        },
      },
      -- snappier smooth scrolling (default total is 200ms)
      scroll = {
        animate = { duration = { step = 10, total = 100 } },
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            layout = { layout = { position = "right" } },
          },
        },
      },
    },
  },

  -- free up <A-n> (LSP "next reference") so it always toggles the explorer
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "<a-n>", false },
          },
        },
      },
    },
  },

  -- `jk` / `jj` to leave insert mode without typing lag, and `jk` to leave terminal mode
  -- (Esc would go to the program instead, e.g. it interrupts Claude Code).
  -- Not in visual mode, where it would cancel selections when moving down then up.
  -- lazygit opts out of the terminal mapping in config/autocmds.lua.
  {
    "max397574/better-escape.nvim",
    event = { "InsertEnter", "TermOpen" },
    opts = {
      default_mappings = false,
      mappings = {
        i = { j = { k = "<Esc>", j = "<Esc>" } },
        t = { j = { k = "<C-\\><C-n>" } },
      },
    },
  },
}
