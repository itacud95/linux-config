call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'vim-airline/vim-airline'
Plug 'cjuniet/clang-format.vim'
Plug 'windwp/nvim-autopairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }

Plug 'neovim/nvim-lspconfig'

" ConfigFile: ~/.config/nvim/coc-settings.json
" ConfigCmd: :CocConfig
" Depends on nodejs: yay -S nodejs
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'airblade/vim-gitgutter'

" themes
Plug 'navarasu/onedark.nvim'
Plug 'kepano/flexoki-neovim'
Plug 'joshdick/onedark.vim'
Plug 'ellisonleao/gruvbox.nvim'

Plug 'Pocco81/auto-save.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'

Plug 'numToStr/Comment.nvim'

Plug 'numToStr/Comment.nvim'

Plug 'ibhagwan/fzf-lua'
Plug 'rmagatti/auto-session'

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
" Plug 'nvim-tree/nvim-tree.lua'
Plug 'kdheepak/lazygit.nvim'

" auto open tabs
Plug 'romgrk/barbar.nvim'

Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

Plug 'kevinhwang91/promise-async'
" Plug 'kevinhwang91/nvim-ufo'
Plug 'Mofiqul/vscode.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
call plug#end()

" Map <leader> to a space
let mapleader = "\<Space>"

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

" debugging
" https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
" https://github.com/mfussenegger/nvim-dap
" https://davelage.com/posts/nvim-dap-getting-started/

nnoremap <silent> <F5> <cmd>lua require'dap'.continue()<cr>
nnoremap <silent> <F10> <cmd>lua require'dap'.step_over()<cr>
nnoremap <silent> <F11> <cmd>lua require'dap'.step_into()<cr>
nnoremap <silent> <F12> <cmd>lua require'dap'.step_out()<cr>

nnoremap <leader>b <cmd>lua require('dap').toggle_breakpoint()<cr>

" require("dapui").open()
" require("dapui").close()
" require("dapui").toggle()

" lua require('dap').toggle_breakpoint()

" nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
" nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

" nnoremap <leader>sl :lua require("nvim-possession").list()<CR>

" nvin-tree
lua vim.g.loaded_netrwPlugin = 1
lua vim.g.loaded_netrw = 1
lua vim.opt.termguicolors = true
nnoremap fe <cmd>NvimTreeFindFile<cr>
nnoremap <C-b> <cmd>NvimTreeToggle<cr>

" folding
set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
" set foldenable=true

lua require("auto-save").setup({})

luafile /home/jk/linux-config/nvim/auto-session.lua
luafile /home/jk/linux-config/nvim/telescope.lua
luafile /home/jk/linux-config/nvim/lualine.lua
luafile /home/jk/linux-config/nvim/autopairs.lua
luafile /home/jk/linux-config/nvim/gruvbox.lua
" luafile /home/jk/linux-config/nvim/nvim-tree.lua
luafile /home/jk/linux-config/nvim/neo-tree.lua
luafile /home/jk/linux-config/nvim/dap.lua
luafile /home/jk/linux-config/nvim/barbar.lua

" Configure nvim-possession
let g:nvim_possession_enable_default_mappings = 0

nnoremap <c-1> N
nnoremap <c-2> *N
nnoremap <c-3> n

nnoremap <leader>lg <cmd>LazyGit<cr>

" https://github.com/numToStr/Comment.nvim
lua require("Comment").setup()
lua require('toggle_lsp_diagnostics').init()

" colorscheme flexoki-dark
" colorscheme onedark
set background=dark
" colorscheme gruvbox
" colorscheme github_dark
lua require('vscode').load('dark')
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
nnoremap fb <cmd>Neotree reveal<cr>

" tabs
noremap <C-S-PageUp>  :-tabmove<cr>
noremap <C-S-PageDown> :+tabmove<cr>
nnoremap <C-w> <cmd>BufferClose<cr>

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

