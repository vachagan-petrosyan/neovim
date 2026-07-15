-- lua/plugins/gitsigns.lua
-- Gitsigns: git status per line, hunk operations, blame.
-- Requires (add to pack.lua): https://github.com/lewis6991/gitsigns.nvim

-- ========================================================================
-- Step 1: options table (start empty, grow as needed)
-- ========================================================================
local opts = {}

-- ========================================================================
-- Step 2: gutter signs
-- ========================================================================
opts.signs = {
  add          = { text = "│" },
  change       = { text = "│" },
  delete       = { text = "_" },
  topdelete    = { text = "‾" },
  changedelete = { text = "~" },
  untracked    = { text = "┆" },
}
opts.signcolumn = true              -- show signs (toggle: :Gitsigns toggle_signs)

-- show staged hunks with their own (dimmer) signs instead of hiding them
opts.signs_staged_enable = true
opts.signs_staged = {
  add          = { text = "│" },
  change       = { text = "│" },
  delete       = { text = "_" },
  topdelete    = { text = "‾" },
  changedelete = { text = "~" },
  untracked    = { text = "┆" },
}

-- ========================================================================
-- Step 3: current-line blame (virtual text at end of line)
-- off by default; toggle live with <leader>gB below
-- ========================================================================
opts.current_line_blame = false
opts.current_line_blame_opts = {
  virt_text = true,
  virt_text_pos = "eol",
  delay = 500,                      -- ms before blame appears
}
opts.current_line_blame_formatter = "<author>, <author_time:%R> - <summary>"

-- ========================================================================
-- Step 4: behavior
-- ========================================================================
opts.attach_to_untracked = true     -- show signs in files not yet in git
opts.update_debounce = 100          -- ms; how quickly signs react to edits
opts.max_file_length = 40000        -- don't attach to huge files (lines)
opts.preview_config = {
  border = "rounded",
}

-- ========================================================================
-- Step 5: keymaps (defined on attach, buffer-local, only in git repos)
-- ========================================================================
opts.on_attach = function(bufnr)
  local gs = require("gitsigns")
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- navigation between hunks (falls back to normal ]c/[c in diff mode)
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gs.nav_hunk("next")
    end
  end, "Next hunk")

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gs.nav_hunk("prev")
    end
  end, "Previous hunk")

  -- hunk operations
  map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
  map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
  map("v", "<leader>gs", function()
    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "Stage selected lines")
  map("v", "<leader>gr", function()
    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "Reset selected lines")
  -- note: staging an already-staged hunk UNstages it (stage_hunk toggles)
  map("n", "<leader>gp", gs.preview_hunk, "Preview hunk (popup)")
  map("n", "<leader>gi", gs.preview_hunk_inline, "Preview hunk (inline)")

  -- whole buffer
  map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
  map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")

  -- blame
  map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line (popup)")
  map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")

  -- diff against index / previous commit
  map("n", "<leader>gd", gs.diffthis, "Diff this file")
  map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff vs last commit")

  -- dump hunks into the quickfix list (navigate with ]q / [q)
  map("n", "<leader>gq", gs.setqflist, "Hunks -> quickfix (buffer)")
  map("n", "<leader>gQ", function() gs.setqflist("all") end, "Hunks -> quickfix (all files)")

  -- toggles
  map("n", "<leader>gw", gs.toggle_word_diff, "Toggle word diff")

  -- hunk as a text object: e.g. vih selects hunk, dih deletes it
  map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>", "Select hunk")
end

-- ========================================================================
-- Step 6: apply
-- ========================================================================
require("gitsigns").setup(opts)
