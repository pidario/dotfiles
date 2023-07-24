"1- Install basic stuff
"("npm is available in the community repo but it's possible to install it using its
"install script and then use itself to upgrade it and install other versions:
"curl -qL https://www.npmjs.com/install.sh | sh
"npm install -g npm@<VERSION>
"or install using community repo:
"yay -S npm
"in order to install npm, nodejs is required)
"yay -S neovim ripgrep fzf python python-pip
"1.1- Install other stuff
"yay -S shellcheck-bin clang ninja go go-tools gopls rustup flutter node-lts-gallium lua-language-server lua luarocks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"rust (needs rustup):
"rustup toolchain install stable
"rustup component add cargo rust-analyzer rust-analysis rust-docs rustfmt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nodejs (needs nodejs and npm):
"npm install -g eslint prettier @angular/cli @angular/language-server @angular/language-service @angular/compiler svelte-language-server typescript typescript-language-server
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"for python development:
"yay -S autopep8 python-pylint python-lsp-server
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"to install/update all plugins:
"chezmoi apply -R (--refresh-externals)

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
set completeopt=menu,menuone,noselect
set lazyredraw

nnoremap <silent> <Esc> :noh<CR>
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
nnoremap <C-p> :FZF<CR>
nnoremap <leader>\ :Buffers<CR>
nnoremap <A-k> :move-2<CR>
nnoremap <A-j> :move+<CR>
nnoremap j jzz
nnoremap k kzz
nnoremap <Up> <Up>zz
nnoremap <Down> <Down>zz
nnoremap <PageUp> <PageUp>zz
nnoremap <PageDown> <PageDown>zz
nnoremap cc :source $MYVIMRC<CR>
nnoremap tn :TestNearest<CR>
nnoremap tf :TestFile<CR>
nnoremap ts :TestSuite<CR>
nnoremap tl :TestLast<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
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
nnoremap <C-f> :Rg <C-R><C-W><CR>
vnoremap <C-f> y:Rg <C-r>"<CR>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:coq_settings = { 'auto_start': 'shut-up' }
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:gitgutter_set_sign_backgrounds = 0
let g:VimuxUseNearest = 0
let test#strategy = "vimux"
let test#go#gotest#options = '-v'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --ignore-vcs --glob "!.git"'

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
	\'lua': ['luac'],
	\'sh': ['shellcheck']
\ }
let g:ale_fixers = {
	\'python': ['autopep8'],
	\'javascript': ['eslint'],
	\'typescript': ['prettier'],
	\'html': ['prettier'],
	\'go': ['gofmt', 'goimports'],
	\'rust': ['rustfmt'],
	\'c': ['clang-format'],
	\'cpp': ['clang-format']
\ }
let g:ale_fix_on_save = 1
"------------------ lua ------------------
lua require("session")
lua require("treesitter")
lua require("lsp")
"lua require("dap")
