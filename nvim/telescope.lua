require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "third_party" },
        mappings = {
            i = {
                ["<c-r>"] = require("telescope.actions").select_vertical,
            },
        },
        -- layout_strategy = "horizontal",
        -- layout_config = { prompt_position = "top" },
        -- border = true
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

require("telescope").load_extension("live_grep_args")
