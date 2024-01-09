local lspconfig = require('lspconfig')

lspconfig.clangd.setup {}

-- yay -S lua-language-server
lspconfig.lua_ls.setup {}

-- yay -S vscode-langservers-extracted
lspconfig.jsonls.setup{}

-- lspconfig.cmake.setup {
--     settings = {
--         filetypes = { "cmake", "CMakeLists.txt" }
--     }
-- }
