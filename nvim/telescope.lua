require("telescope").setup({
    extensions = {
        frecency = {
            previewer = false,
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        oldfiles = {
            cwd_only = true,
        },
    },
})

