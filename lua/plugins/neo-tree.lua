return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module 'neo-tree'
    ---@type neotree.Config
    keys = {
        { '\\', ':Neotree toggle<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
        -- Filesystem options
        filesystem = {
            filtered_items = {
                -- Hide filtered items on open
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_by_name = {
                    -- '.git',
                    -- '.DS_Store',
                    -- 'thumbs.db',
                },
                --never_show = {".git"},
                never_show = { },
            },
        },
    }
}
