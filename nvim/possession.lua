require("nvim-possession").setup({
    sessions = {
        sessions_path = "/home/jk/linux-config/nvim/sessions/",
    	sessions_variable = "session",
	    sessions_icon = "📌",
    	sessions_prompt = "sessions:",
    },
    autoload = true,
    autosave = true,
    autoswitch = {
        enable = false, -- whether to enable autoswitch
        exclude_ft = {}, -- list of filetypes to exclude from autoswitch
    },
    save_hook = function()
        -- Get visible buffers
        local visible_buffers = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            visible_buffers[vim.api.nvim_win_get_buf(win)] = true
        end

    end
})


