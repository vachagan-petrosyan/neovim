-- lua/plugins/neotree.lua
-- Neo-tree file explorer, built up step by step in an `opts` table.
-- Requires (already in pack.lua): neo-tree.nvim v3, plenary.nvim,
-- nui.nvim, nvim-web-devicons.

-- ========================================================================
-- Step 1: options table (start empty, grow as needed)
-- ========================================================================
local opts = {}

-- ========================================================================
-- Step 2: general behavior
-- ========================================================================
opts.close_if_last_window = true    -- quit nvim if neo-tree is the last window
opts.popup_border_style = "rounded"

-- ========================================================================
-- Step 3: window (position and size of the tree)
-- ========================================================================
opts.window = {
  position = "left",   -- "left", "right", "float", "current"
  width = 32,
}

-- ========================================================================
-- Step 4: filesystem source behavior
-- ========================================================================
opts.filesystem = {}

-- show/hide dotfiles and gitignored files (toggle in tree with H)
opts.filesystem.filtered_items = {
  visible = true,          -- true = show filtered items dimmed instead of hiding
  hide_dotfiles = false,    -- we want to see dotfiles like .gitignore
  hide_gitignored = true,
  hide_by_name = { ".git", "node_modules", "__pycache__" },
}

-- keep the tree in sync with the file you are editing
opts.filesystem.follow_current_file = {
  enabled = true,
  leave_dirs_open = false,
}

opts.use_popups_for_input = false

-- refresh the tree automatically when files change on disk
opts.filesystem.use_libuv_file_watcher = true

-- what to do when opening a directory (e.g. `nvim .`)
-- "open_default" = neo-tree replaces netrw
opts.filesystem.hijack_netrw_behavior = "open_default"

-- ========================================================================
opts.default_component_configs = {
  git_status = {
    symbols = {
      added = "+",
      modified = "~",
      deleted = "-",
      untracked = "?",
      ignored = "",
      unstaged = "",
      staged = "S",
      conflict = "!",
    },
  },
}

-- ========================================================================
-- Step 6: apply
-- ========================================================================
require("neo-tree").setup(opts)

-- ========================================================================
-- Step 7: keymaps
-- ========================================================================
-- 1. Toggle stays, but smarter reveal
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer: toggle" })

-- 2. Reveal: open tree focused on current file (reveal also opens if closed)
vim.keymap.set("n", "<leader>E", "<cmd>Neotree reveal<cr>", { desc = "Explorer: reveal current file" })

-- 3. Buffers source: tree of open buffers
vim.keymap.set("n", "<leader>be", "<cmd>Neotree buffers toggle<cr>", { desc = "Explorer: open buffers" })

-- 4. Git status source: floating panel of changed files
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status float<cr>", { desc = "Explorer: git status" })

-- 5. Focus tree if open, open if closed (doesn't close — for jumping back)
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Explorer: focus" })
