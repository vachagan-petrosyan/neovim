-- lua/plugins/completion.lua
-- blink.cmp: autocompletion (LSP, paths, snippets, buffer words).

-- ========================================================================
-- Step 1: options table
-- ========================================================================
local opts = {}

-- ========================================================================
-- Step 2: keymap preset
--   "default": <C-y> accept, <C-n>/<C-p> or Up/Down select  (my pick)
--   "enter":   <CR> accept, <Tab>/<S-Tab> select
--   "super-tab": <Tab> accepts (VSCode style)
-- ========================================================================
opts.keymap = { preset = "default" }

-- ========================================================================
-- Step 3: completion behavior
-- ========================================================================
opts.completion = {
  -- show documentation for the selected item automatically
  documentation = {
    auto_show = true,
    auto_show_delay_ms = 200,
  },
  -- don't preselect; insert on select
  list = { selection = { preselect = false, auto_insert = true } },
  -- ghost text: inline preview of the selected item (try it, divisive)
  ghost_text = { enabled = false },
}

-- ========================================================================
-- Step 4: sources
-- ========================================================================
opts.sources = {
  default = { "lsp", "path", "snippets", "buffer" },
}

-- ========================================================================
-- Step 5: signature help while typing function arguments (experimental)
-- ========================================================================
opts.signature = { enabled = true }

-- ========================================================================
-- Step 6: fuzzy matcher — use the prebuilt Rust binary from the release
-- ========================================================================
opts.fuzzy = { implementation = "prefer_rust_with_warning" }

-- ========================================================================
-- Step 7: apply
-- ========================================================================
require("blink.cmp").setup(opts)
