-- lua/plugins/colorscheme.lua
-- Tokyonight, built up step by step in an `opts` table, applied once at the end.
-- NOTE: setup() must run BEFORE `colorscheme tokyonight`.

-- ========================================================================
-- Step 1: options table (start empty, grow as needed)
-- ========================================================================
local opts = {}

-- ========================================================================
-- Step 2: style
-- one of: "storm", "moon" (default), "night" (darkest), "day" (light)
-- "day" is also used automatically when vim.o.background = "light"
-- ========================================================================
opts.style = "night"
opts.light_style = "night"

-- ========================================================================
-- Step 3: background
-- set to true to disable the background color (terminal shows through)
-- ========================================================================
opts.transparent = false

-- ========================================================================
-- Step 4: syntax styles
-- any attr-list accepted by nvim_set_hl (italic, bold, ...)
-- ========================================================================
opts.styles = {
  comments = { italic = true },
  keywords = { italic = true },
  functions = {},
  variables = {},
  sidebars = "dark",   -- "dark", "transparent" or "normal"
  floats = "dark",
}

-- ========================================================================
-- Step 5: extras
-- ========================================================================
opts.terminal_colors = true   -- theme the :terminal colors too
opts.dim_inactive = false     -- set true to dim non-focused windows

-- ========================================================================
-- Step 6: plugin integrations
-- Since we are NOT using lazy.nvim, tokyonight enables ALL plugin
-- highlight groups by default (plugins.all = true when lazy is absent),
-- so blink.cmp, gitsigns, which-key, flash, mini.*, fzf-lua etc. are
-- already covered — nothing to list manually. To trim it down instead:
-- ========================================================================
opts.plugins = {
--   all = true,
    treesitter = true,
--   lualine = true,
--   blink = true,
--   ["which-key"] = true,
--   ["neo-tree"] = true,
}

-- ========================================================================
-- Step 7: fine-grained overrides (optional, uncomment to use)
-- ========================================================================
-- opts.on_colors = function(colors)
--   colors.hint = colors.orange
-- end
-- opts.on_highlights = function(hl, c)
--   hl.CursorLineNr = { fg = c.orange, bold = true }
-- end

-- ========================================================================
-- Step 8: apply — setup() first, then activate the colorscheme
-- ========================================================================
require("tokyonight").setup(opts)

vim.cmd.colorscheme("tokyonight")

