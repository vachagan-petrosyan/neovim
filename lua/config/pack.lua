-- lua/config/pack.lua
vim.pack.add({
  -- MASON
  "https://github.com/mason-org/mason.nvim",
  -- LSP config
  "https://github.com/neovim/nvim-lspconfig",
  -- blink.cmp
  --{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
  -- gitsigns
  "https://github.com/lewis6991/gitsigns.nvim",
  -- lualine
  "https://github.com/nvim-lualine/lualine.nvim",
  -- Colorscheme
  "https://github.com/folke/tokyonight.nvim",

  -- File explorer: neo-tree + its dependencies
  {
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = vim.version.range("3"),
  },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

