require("telescope").setup({
    extensions = {
        frecency = {
            previewer = false,
            -- ignore_patterns is not respected.
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/third_party/*", "**/builddir/**" },
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

