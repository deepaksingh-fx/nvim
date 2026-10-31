return {
  -- extra themes, lazy-loaded by lazy.nvim the first time `:colorscheme <name>` asks for them
  -- (catppuccin and tokyonight already ship with LazyVim)
  { "rebelot/kanagawa.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "Mofiqul/vscode.nvim", lazy = true },
  { "Shatur/neovim-ayu", lazy = true },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    init = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("config.themes").load()
      end,
    },
  },
}
