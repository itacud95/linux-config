require("telescope").setup({
    extensions = {
        frecency = {
            previewer = false,
        },
    },
    pickers = {
        oldfiles = {
            cwd_only = true,
        }
    },
})

