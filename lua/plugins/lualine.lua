-- lua/plugins/lualine.lua
-- Lualine statusline, built up step by step in an `opts` table.
-- Requires (in pack.lua): lualine.nvim, nvim-web-devicons (already present).

-- ========================================================================
-- Step 1: options table (start empty, grow as needed)
-- ========================================================================
local opts = {}

-- ========================================================================
-- Step 2: general appearance
-- ========================================================================
opts.options = {
  theme = "tokyonight",             -- match our colorscheme ("auto" also works)
  icons_enabled = true,
  -- separators between sections/components; set all to "" for a flat look
  section_separators = { left = "", right = "" },
  component_separators = { left = "", right = "" },
  globalstatus = true,              -- ONE statusline for all windows (0.7+)
  disabled_filetypes = {
    statusline = { "neo-tree" },    -- don't draw over the file tree
  },
}

-- ========================================================================
-- Step 3: sections
-- Layout:  | A | B | C          ...          X | Y | Z |
-- defaults: mode | branch,diff,diagnostics | filename ... encoding | progress | location
-- ========================================================================
opts.sections = {
  lualine_a = { "mode" },
  lualine_b = { "branch", "diff", "diagnostics" },
  lualine_c = {
    { "filename", path = 1 },       -- 0 = name only, 1 = relative, 2 = absolute
  },
  lualine_x = {
    "encoding",
    "fileformat",
    "filetype",
  },
  lualine_y = { "progress" },       -- % through file
  lualine_z = { "location" },       -- line:column
}

-- statusline for unfocused windows (only used when globalstatus = false)
opts.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { "filename" },
  lualine_x = { "location" },
  lualine_y = {},
  lualine_z = {},
}

-- ========================================================================
-- Step 4: extensions (prebuilt statuslines for special windows)
-- ========================================================================
opts.extensions = { "neo-tree", "quickfix", "lazy" }

-- ========================================================================
-- Step 5: apply
-- ========================================================================
require("lualine").setup(opts)
