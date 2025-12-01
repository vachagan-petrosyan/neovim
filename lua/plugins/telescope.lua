return {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9",
    dependencies = { 
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        {
            "nvim-telescope/telescope-ui-select.nvim"
        },
        {
            "nvim-tree/nvim-web-devicons",
            enabled = true
        },
    }
}
