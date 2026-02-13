vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

require("config.lazy")

vim.cmd[[colorscheme tokyonight-night]]
vim.opt.number = true

vim.opt.cursorline = true

-- Use ripgrep
if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
  vim.o.grepformat = '%f:%l:%c:%m'
end

-- Keymaps
vim.keymap.set('n', '<leader>g', ':grep <cword><CR>:copen<CR>', { desc = 'Grep word under cursor' })
vim.keymap.set('n', '<leader>G', ':grep ', { desc = 'Grep custom pattern' })

-- Quickfix navigation
vim.keymap.set('n', '<C-n>', ':cnext<CR>', { desc = 'Next quickfix' })
vim.keymap.set('n', '<C-p>', ':cprev<CR>', { desc = 'Previous quickfix' })

