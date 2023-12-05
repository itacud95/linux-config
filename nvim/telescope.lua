require("telescope").setup({
    extensions = {
        frecency = {
            previewer = false,
        },
    },
    defaults = {
        mappings = {
            i = {
                ["<c-r>"] = require("telescope.actions").select_vertical,
            },
        },
    },
    pickers = {
        find_files = {
            -- hidden = true,
            -- no_ignore = false,
        },
        oldfiles = {
            cwd_only = true,
        },
        buffers = {
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer",
                },
            },
        },
    },
})

