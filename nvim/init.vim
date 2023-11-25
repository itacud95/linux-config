call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'vim-airline/vim-airline'
Plug 'cjuniet/clang-format.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'

" https://github.com/mg979/vim-visual-multi
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" https://github.com/nvim-telescope/telescope.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }

Plug 'neovim/nvim-lspconfig'

" ConfigFile: ~/.config/nvim/coc-settings.json
" ConfigCmd: :CocConfig
" Depends on nodejs: yay -S nodejs
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'airblade/vim-gitgutter'

Plug 'navarasu/onedark.nvim'

Plug 'Pocco81/auto-save.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'

Plug 'numToStr/Comment.nvim'

call plug#end()

" nnoremap => normal mode
" inoremap => insert mode
"

lua require("auto-save").setup({})
lua require("telescope").load_extension("frecency")
luafile /home/jk/linux-config/nvim/telescope.lua

" https://github.com/numToStr/Comment.nvim
lua require("Comment").setup()

colorscheme onedark
set scrolloff=10

" tab
set tabstop=4
set shiftwidth=4
set expandtab

" Map <leader> to a space
let mapleader = "\<Space>"

inoremap jj <Esc>

inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>               " save and exit
nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:qa!<cr>               " quit discarding changes
nnoremap <C-q> :qa!<cr>

" find & navigation
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-;> <cmd>Telescope live_grep<cr>

:set number
set clipboard+=unnamedplus

" https://github.com/nvim-telescope/telescope.nvim
nnoremap fa <cmd>Telescope find_files<cr>
nnoremap ff <cmd>Telescope find_files find_command=rg,--ignore,--files,--sort,accessed<cr>
nnoremap fo <cmd>Telescope oldfiles<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>

" NERDTree
nnoremap fe <cmd>NERDTreeFind %<cr>
nnoremap <C-b> <cmd>NERDTreeToggle<cr>

lua require("lspconfig").clangd.setup({})

nnoremap gd <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap gf <cmd>lua vim.lsp.buf.format()<cr>
nnoremap ga <cmd>lua vim.lsp.buf.code_action()<cr>

" maybe no longer used
" luafile /home/jk/linux-config/nvim/complete.lua

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

