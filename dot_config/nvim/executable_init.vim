"1- Install basic stuff
"yay -S neovim neovim-drop-in ripgrep fzf
"1.1- Install other stuff (if needed)
"yay -S shellcheck-bin clang ninja go go-tools gopls rustup flutter node-lts-fermium npm python lua-language-server lua luarocks jdk11-openjdk jdtls
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"rust (needs rustup):
"rustup toolchain install stable
"rustup component add cargo rls rust-analysis rust-docs rustfmt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nodejs (needs node-lts-fermium and npm):
"npm install -g eslint prettier @angular/cli @angular/language-server @angular/language-service @angular/compiler svelte-language-server typescript typescript-language-server
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"python (needs python):
"python -m ensurepip --upgrade
"pip install --upgrade pip autopep8 pylint python-lsp-server[all]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"to install all plugins (it will install oh-my-zsh too):
"cd $XDG_DATA_HOME
"mkdir nvim
"git clone https://github.com/pidario/submodules.git --recurse-submodules
"or
"git clone git@github.com:pidario/submodules.git --recurse-submodules
"ln -s $XDG_DATA_HOME/submodules/site $XDG_DATA_HOME/nvim/site
"to install a new plugin
"cd submodules
"git submodule add https://github.com/$USER_ORG/$REPO.git site/pack/my-plugins/start/$REPO
"to update all submodules
"git submodule update --recursive --remote --merge
"to remove a submodule
"git submodule deinit $SUBMODULE_PATH
"git rm $SUBMODULE_PATH
"rm -Rf .git/modules/$SUBMODULE_PATH
"after update/removal or new install don't forget to commit and push

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
nnoremap <C-f> :Rg <C-R><C-W><CR>
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
let g:gitgutter_set_sign_backgrounds = 0
let test#strategy = "neovim"
let test#go#gotest#options = '-v'
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git"'

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
"------------------ vsnip ------------------
" Expand
imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'

" Expand or jump
imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap s <Plug>(vsnip-select-text)
xmap s <Plug>(vsnip-select-text)
nmap S <Plug>(vsnip-cut-text)
xmap S <Plug>(vsnip-cut-text)
let g:vsnip_snippet_dir = '$XDG_CONFIG_HOME/nvim/vsnip'
"------------------ lua ------------------
lua require("treesitter")
lua require("completion")
lua require("lsp")
"lua require("dap")
