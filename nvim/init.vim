call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'vim-airline/vim-airline'
Plug 'cjuniet/clang-format.vim'
Plug 'windwp/nvim-autopairs'
" Plug 'preservim/nerdtree'

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
Plug 'nvim-tree/nvim-tree.lua'
Plug 'kdheepak/lazygit.nvim'

Plug 'romgrk/barbar.nvim'

Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'Mofiqul/vscode.nvim'
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

" nvin-tree
lua vim.g.loaded_netrwPlugin = 1
lua vim.g.loaded_netrw = 1
lua vim.opt.termguicolors = true
" lua require('nvim-tree').setup({})
nnoremap fe <cmd>NvimTreeFindFile<cr>
nnoremap <C-b> <cmd>NvimTreeToggle<cr>

" Map <leader> to a space
let mapleader = "\<Space>"

" folding
set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
" set foldenable=true

lua require("auto-save").setup({})
" lua require("telescope").load_extension("frecency")
lua require("telescope").load_extension("live_grep_args")
lua require('ufo').setup({})

luafile /home/jk/linux-config/nvim/possession.lua
luafile /home/jk/linux-config/nvim/telescope.lua
luafile /home/jk/linux-config/nvim/lualine.lua
luafile /home/jk/linux-config/nvim/autopairs.lua
luafile /home/jk/linux-config/nvim/gruvbox.lua
luafile /home/jk/linux-config/nvim/nvim-tree.lua

" Configure nvim-possession
let g:nvim_possession_enable_default_mappings = 0

" Map commands to leader key
nnoremap <leader>sl :lua require("nvim-possession").list()<CR>
nnoremap <leader>sn :lua require("nvim-possession").new()<CR>
nnoremap <leader>su :lua require("nvim-possession").update()<CR>
nnoremap <leader>sd :lua require("nvim-possession").delete()<CR>

nnoremap <c-1> N
nnoremap <c-2> *N
nnoremap <c-3> n

nnoremap lg <cmd>LazyGit<cr>

" https://github.com/numToStr/Comment.nvim
lua require("Comment").setup()
lua require('toggle_lsp_diagnostics').init()
" ToggleDiag

" colorscheme flexoki-dark
" colorscheme onedark
set background=dark
" colorscheme gruvbox
" colorscheme github_dark
set scrolloff=14

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
" nnoremap <leader>/ <cmd>:noh<cr>.
" jump back and forth
nnoremap mm <C-6>

:set number
set clipboard+=unnamedplus

" https://github.com/nvim-telescope/telescope.nvim
nnoremap fa <cmd>Telescope find_files<cr>
nnoremap fr <cmd>Telescope frecency workspace=CWD previewer=false<cr>
" nnoremap ff <cmd>Telescope find_files find_command=rg,--files,--ignore,|,xargs,stat,--format='%X %n',|,sort,-n<cr>
nnoremap ff <cmd>Telescope find_files find_command=rg,--ignore,--files,--sortr,accessed<cr>
nnoremap fo <cmd>Telescope oldfiles<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>

" tabs
noremap <C-S-PageUp>  :-tabmove<cr>
noremap <C-S-PageDown> :+tabmove<cr>

nnoremap <C-PageUp> <cmd>BufferPrevious<cr>
nnoremap <C-PageDown> <cmd>BufferNext<cr>
nnoremap <C-S-PageUp> <cmd>BufferMovePrevious<cr>
nnoremap <C-S-PageDown> <cmd>BufferMoveNext<cr>
nnoremap <C-k><C-o> <cmd>BufferCloseAllButCurrent<cr>

" NERDTree
" nnoremap fe <cmd>NERDTreeFind %<cr>
" nnoremap <C-b> <cmd>NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

luafile /home/jk/linux-config/nvim/lsp.lua
" lua require("lspconfig").clangd.setup({})
" lua require("lspconfig").cmake.setup({})

nnoremap gd <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap gf <cmd>lua vim.lsp.buf.format()<cr>
nnoremap ga <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap go <cmd>ClangdSwitchSourceHeader<cr>
nnoremap gi <cmd>ToggleDiag<cr>

" maybe no longer used
" luafile /home/jk/linux-config/nvim/complete.lua

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

