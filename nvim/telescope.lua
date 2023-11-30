require("telescope").setup({
    extensions = {
        frecency = {
            previewer = false,
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
    },
})

