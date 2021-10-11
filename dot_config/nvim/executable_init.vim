"1- Install neovim, neovim-drop-in, vim-plug and ripgrep
"yay -S neovim neovim-drop-in vim-plug ripgrep
"2- Install all plugins
":PlugInstall
"3- Install treesitter parsers (if needed)
":TSInstall <LANG>
"4- To update plugins:
":PlugUpdate

call plug#begin(stdpath('data') . '/plugged')
Plug 'dense-analysis/ale'
Plug 'rmagatti/auto-session'
Plug 'nvim-lua/completion-nvim'
Plug 'kien/ctrlp.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-sleuth'
Plug 'vim-test/vim-test'
call plug#end()

syntax on

set modeline
"set expandtab
"set tabstop=4
"set shiftwidth=4
set foldmethod=indent
set nofoldenable
set diffopt+=vertical
set number relativenumber
set clipboard+=unnamedplus
set noswapfile
set nobackup
set hidden
set mouse=a
set termguicolors
set background=dark
set cursorline
set belloff=""
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:␣
set list
set guicursor=a:block-Cursor-blinkon0,i-ci:ver100,r-cr:hor100

nnoremap <C-PageDown> :bn<CR>
nnoremap <C-PageUp> :bp<CR>
nnoremap <C-w> :bdelete<CR>
nnoremap <C-A-w> :bdelete!<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-A-s> :w!<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-A-q> :q!<CR>
nnoremap <A-w> :wincmd w<CR>
nnoremap <C-b> :Vexplore<CR>
nnoremap <A-k> :move-2<CR>
nnoremap <A-j> :move+<CR>
nnoremap cc :source $MYVIMRC<CR>
nnoremap tn :TestNearest<CR>
nnoremap tf :TestFile<CR>
nnoremap ts :TestSuite<CR>
nnoremap tl :TestLast<CR>
nnoremap gd :Gdiffsplit<CR>
nnoremap <leader>tt :set noexpandtab<CR>:retab!<CR>
nnoremap <leader><space><space> :set tabstop=4 shiftwidth=4 expandtab<CR>:retab<CR>
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:gitgutter_set_sign_backgrounds = 0
let test#strategy = "neovim"
let test#go#gotest#options = '-v'
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

hi SignColumn guibg=#262626
hi LineNr guifg=grey guibg=NONE
hi CursorLineNr guibg=NONE guifg=#d7af00
hi Visual guibg=fg guifg=bg gui=reverse
hi Cursor guibg=fg guifg=bg gui=reverse
hi CursorLine guibg=#000000
hi Pmenu guibg=#606060
hi PmenuSel guifg=#dddd00 guibg=#1f82cd
hi PmenuSbar guibg=#d6d6d6
hi ExtraWhitespace guibg=red
match ExtraWhitespace /\s\+$/

"------------------ ale ------------------
hi clear ALEErrorSign
hi clear ALEWarningSign
hi clear ALEInfoSign
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_info = '^^'
hi Error guifg=#ff5f87 guibg=NONE
hi Warning guifg=#d7af00 guibg=NONE
hi Info guifg=#00f3ff guibg=NONE
hi link ALEErrorSign Error
hi link ALEWarningSign Warning
hi link ALEInfoSign Info

let g:ale_linters = {
	\'python': ['pylint'],
	\'javascript': ['eslint'],
	\'go': ['golint', 'gofmt'],
	\'rust': ['rls'],
	\'lua': ['luacheck', 'luac'],
	\'sh': ['shellcheck']
\ }
let g:ale_fixers = {
	\'python': ['autopep8'],
	\'javascript': ['eslint'],
	\'go': ['gofmt', 'goimports'],
	\'rust': ['rustfmt'],
	\'c': ['clang-format'],
	\'cpp': ['clang-format']
\ }
let g:ale_fix_on_save = 1

"------------------ completion-nvim ------------------
let g:completion_trigger_character = ['.', '::', '->']
let g:completion_trigger_on_delete = 1
"Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
"Avoid showing message extra message when using completion
set shortmess+=c

"------------------ lua ------------------
lua require("treesitter")
lua require("lsp")
"lua require("dap")
