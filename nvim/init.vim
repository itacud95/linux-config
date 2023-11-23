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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-file-browser.nvim'

call plug#end()

" nnoremap => normal mode
" inoremap => insert mode
"

set scrolloff=10

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
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
" nnoremap fh <cmd>Telescope help_tags<cr>
" NERDTree
nnoremap fe <cmd>NERDTreeToggle<cr>
nnoremap <C-b> <cmd>NERDTreeToggle<cr>

lua require("lspconfig").clangd.setup({})

nnoremap gd <cmd>lua vim.lsp.buf.declaration()<cr>

luafile /home/jk/linux-config/nvim/complete.lua

