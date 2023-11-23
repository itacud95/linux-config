vim.o.completeopt = "noinsert,menuone,noselect"

local cmd = vim.cmd

local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

-- When the <Enter> key is pressed while the popup menu is visible, it only
-- hides the menu. Use this mapping to close the menu and also start a new
-- line.
map{expr = true, 'i', "<cr>", 'pumvisible() ? "\\<C-y>" : "\\<cr>"'}
-- Use <TAB> to select the popup menu:
map{expr = true, 'i', "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"'}
map{expr = true, 'i', "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"'}

