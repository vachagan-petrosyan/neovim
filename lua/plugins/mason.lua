-- lua/plugins/mason.lua
-- Mason: installer for external tools (LSP servers, formatters, linters).
-- vim.pack manages plugins; Mason manages the BINARIES those plugins use.

-- ========================================================================
-- Step 1: options
-- ========================================================================
local opts = {}

opts.ui = {
  border = "rounded",              -- match our float style
  icons = {
    package_installed = "+",
    package_pending = "~",
    package_uninstalled = "-",
  },
}

-- ========================================================================
-- Step 2: apply (this also prepends mason/bin to Neovim's PATH)
-- ========================================================================
require("mason").setup(opts)
