call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'vim-airline/vim-airline'
Plug 'cjuniet/clang-format.vim'
Plug 'windwp/nvim-autopairs'
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

" themes
Plug 'navarasu/onedark.nvim'
Plug 'kepano/flexoki-neovim'
Plug 'joshdick/onedark.vim'
Plug 'ellisonleao/gruvbox.nvim'

Plug 'Pocco81/auto-save.nvim'
" Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'

Plug 'numToStr/Comment.nvim'

Plug 'numToStr/Comment.nvim'

Plug 'ibhagwan/fzf-lua'
Plug 'gennaro-tedesco/nvim-possession'

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'kdheepak/lazygit.nvim'

call plug#end()

" chat gpt auto-trim-whitespace
function! TrimWhitespace()
    let l:save_cursor = getpos(".")
    keeppatterns %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfunction
augroup TrimWhitespace
    autocmd!
    autocmd BufWritePre * call TrimWhitespace()
augroup END


" Map <leader> to a space
let mapleader = "\<Space>"


lua require("auto-save").setup({})
" lua require("telescope").load_extension("frecency")
lua require("telescope").load_extension("live_grep_args")

luafile /home/jk/linux-config/nvim/possession.lua
luafile /home/jk/linux-config/nvim/telescope.lua
luafile /home/jk/linux-config/nvim/lualine.lua
luafile /home/jk/linux-config/nvim/autopairs.lua

" Configure nvim-possession
let g:nvim_possession_enable_default_mappings = 0

" Map commands to leader key
nnoremap <leader>sl :lua require("nvim-possession").list()<CR>
nnoremap <leader>sn :lua require("nvim-possession").new()<CR>
nnoremap <leader>su :lua require("nvim-possession").update()<CR>
nnoremap <leader>sd :lua require("nvim-possession").delete()<CR>

" https://github.com/numToStr/Comment.nvim
lua require("Comment").setup()

" colorscheme onedark
" colorscheme flexoki-dark
" colorscheme onedark
set background=dark
colorscheme gruvbox
set scrolloff=10

" tab
set tabstop=4
set shiftwidth=4
set expandtab


inoremap jj <Esc>

inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>               " save and exit
nnoremap <C-d> :wq!<cr>
" nnoremap <C-w> :wq!<cr>
inoremap <C-q> <esc>:qa!<cr>               " quit discarding changes
nnoremap <C-q> :qa!<cr>

" delete without copy
nnoremap <leader>d "_dd

" find & navigation
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-;> <cmd>Telescope live_grep<cr>

" stop search highlight
nnoremap <Leader>f :noh<cr>.
" jump back and forth
nnoremap mm <C-6>

:set number
set clipboard+=unnamedplus

" https://github.com/nvim-telescope/telescope.nvim
nnoremap fa <cmd>Telescope find_files<cr>
nnoremap fr <cmd>Telescope find_files find_command=rg,--ignore,--files,--sort,accessed<cr>
" nnoremap ff <cmd>Telescope frecency workspace=CWD previewer=false<cr>
" nnoremap ff <cmd>Telescope find_files find_command=rg,--files,--ignore,|,xargs,stat,--format='%X %n',|,sort,-n<cr>
nnoremap ff <cmd>Telescope find_files find_command=rg,--ignore,--files,--sortr,accessed<cr>
nnoremap fo <cmd>Telescope oldfiles<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>

" tabs
noremap <C-S-PageUp>  :-tabmove<cr>
noremap <C-S-PageDown> :+tabmove<cr>

" NERDTree
nnoremap fe <cmd>NERDTreeFind %<cr>
nnoremap <C-b> <cmd>NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

luafile /home/jk/linux-config/nvim/lsp.lua
" lua require("lspconfig").clangd.setup({})
" lua require("lspconfig").cmake.setup({})

nnoremap gd <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap gf <cmd>lua vim.lsp.buf.format()<cr>
nnoremap ga <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap go <cmd>ClangdSwitchSourceHeader<cr>

" maybe no longer used
" luafile /home/jk/linux-config/nvim/complete.lua

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

