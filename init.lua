-- ~/.config/nvim/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

require("config.pack")          -- All plugin declarations live here
require("plugins.colorscheme")  -- tokyonight setup + activate
require("plugins.neotree")   	-- neotree setup 
require("plugins.lualine")	-- Lualin.nvim
require("plugins.gitsigns")	-- Git signs plugin
require("plugins.lspconfig")    -- nvim-lspconfig
require("plugins.mason")	-- mason

--require("plugins.completion")	-- blink.cmp
