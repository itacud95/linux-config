local lspconfig = require('lspconfig')

lspconfig.clangd.setup {}

lspconfig.cmake.setup {
    settings = {
        filetypes = { "cmake", "CMakeLists.txt" }
    }
}

