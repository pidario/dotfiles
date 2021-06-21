" 1- Install neovim-nightly-bin (or neovim-git), neovim-drop-in, vim-plug and ripgrep
" yay -S neovim-nightly-bin neovim-drop-in vim-plug ripgrep
" 2- Install all plugins
" :PlugInstall
" 3- Install treesitter parsers (if needed)
" :TSInstall <LANG>
" 4- To update plugins:
" :PlugUpdate

call plug#begin(stdpath('data') . '/plugged')
Plug 'dense-analysis/ale'
Plug 'nvim-lua/completion-nvim'
Plug 'kien/ctrlp.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-sleuth'
Plug 'vim-test/vim-test'
Plug 'mg979/vim-visual-multi'
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
nnoremap <C-z> :undo<CR>
nnoremap <C-y> :redo<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-A-s> :w!<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-A-q> :q!<CR>
nnoremap <A-w> :wincmd w<CR>
nnoremap <C-b> :NvimTreeToggle<CR>
nnoremap <C-f> :Rg<CR>
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

let g:airline#extensions#tabline#enabled = 1
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:VM_mouse_mapings = 1
let g:VM_default_mappings = 0
let g:VM_theme = 'iceblue'
let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'
let g:VM_maps["Mouse Cursor"] = '<A-LeftMouse>'
let g:VM_maps["Mouse Word"] = '<M-A-RightMouse>'
let g:VM_maps["Mouse Column"] = '<A-RightMouse>'
let g:VM_maps["Add Cursor Up"] = '<A-Up>'
let g:VM_maps["Add Cursor Down"] = '<A-Down>'
let g:gitgutter_set_sign_backgrounds = 0
let test#strategy = "neovim"
let test#go#gotest#options = '-v'
let g:nvim_tree_group_empty = 1
let g:nvim_tree_icons = {
	\ 'default': '',
	\ 'symlink': '🔗',
	\ 'git': {
		\ 'unstaged': "✗",
		\ 'staged': "✓",
		\ 'unmerged': "⚠",
		\ 'renamed': "➜",
		\ 'untracked': "★"
	\ },
	\ 'folder': {
		\ 'default': "🗀",
		\ 'open': "🗁"
	\ }
\ }

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
	\ 'python': ['pylint'],
	\ 'javascript': ['eslint'],
	\ 'go': ['golint', 'gofmt'],
	\ 'rust': ['rls'],
	\ 'lua': ['luacheck', 'luac'],
	\ 'sh': ['shellcheck']
\ }
let g:ale_fixers = {
	\ 'python': ['autopep8'],
	\ 'javascript': ['eslint'],
	\ 'go': ['gofmt', 'goimports'],
	\ 'rust': ['rustfmt']
\ }
let g:ale_fix_on_save = 1
" ------------------ completion-nvim ------------------
let g:completion_trigger_character = ['.', '::', '->']
let g:completion_trigger_on_delete = 1
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" ------------------ lua ------------------
lua <<EOF
local lspconfig = require('lspconfig')
local completion = require('completion')
local home = os.getenv('HOME')
local lua_lsp_dir = home .. '/workspace/lua-language-server'
------------------ nvim-treesitter ------------------
require'nvim-treesitter.configs'.setup {
	-- one of "all", "language", or a list of languages
	ensure_installed = "all",
	highlight = {
		-- false will disable the whole extension
		enable = true,
	},
}
require'nvim-treesitter.configs'.setup {
	refactor = {
		highlight_definitions = { enable = true },
		-- highlight_current_scope = { enable = true },
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				goto_next_usage = "<a-*>",
				goto_previous_usage = "<a-#>",
			},
		},
	},
}
------------------ nvim-lsp ------------------
lspconfig.gopls.setup{
	name = "gopls";
	on_attach = completion.on_attach;
	cmd = {"gopls"};
	filetypes = {'go','gomod'};
	root_patterns = {'go.mod','.git'};
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#settings
	init_options = {
		usePlaceholders=true;
		linkTarget="pkg.go.dev";
		completionDocumentation=true;
		completeUnimported=true;
		deepCompletion=true;
		fuzzyMatching=true;
	};
}
lspconfig.tsserver.setup{
	on_attach = completion.on_attach;
}
lspconfig.pyls.setup{
	on_attach = completion.on_attach;
}
lspconfig.rls.setup{
	on_attach = completion.on_attach;
}
lspconfig.sumneko_lua.setup{
	cmd = {lua_lsp_dir .. '/bin/Linux/lua-language-server', '-E', lua_lsp_dir .. '/main.lua'};
	on_attach = completion.on_attach;
}
lspconfig.jdtls.setup{
	cmd = { "jdtls.sh" };
	filetypes = { "java" };
	root_dir = require'lspconfig/util'.root_pattern(".git", "pom.xml");
	on_attach = completion.on_attach;
}
lspconfig.dartls.setup{
	on_attach = completion.on_attach;
}
------------------ nvim-dap ------------------
--require('dap.ext.vscode').load_launchjs()
local dap = require('dap')
dap.set_log_level('TRACE')
dap.adapters.python = {
	type = 'executable';
	command = '/usr/bin/python';
	args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
	{
		type = 'python';
		request = 'launch';
		name = 'Launchpy';
		program = "${file}";
		pythonPath = function(adapter)
			return '/usr/bin/python'
		end;
	};
}
dap.adapters.javascript = {
	--type = 'server';
	--host = '127.0.0.1';
	--port = 9229;
	type = 'executable';
	command = '/usr/bin/node';
	args = {home .. '/workspace/vscode-node-debug2/out/src/nodeDebug.js'};
}
dap.configurations.javascript = {
	{
		type = 'javascript';
		request = 'launch';
		name = 'debug';
		program = "${workspaceFolder}/index.js";
	},
}
dap.adapters.go = {
	type = 'executable';
	command = '/usr/bin/node';
	args = {home .. '/workspace/vscode-go/dist/debugAdapter.js'};
	--args = {'dap'};
}
dap.configurations.go = {
	{
		type = 'go';
		request = 'launch';
		name = 'go';
		program = "${workspaceFolder}";
		dlvToolPath = '/usr/bin/dlv'
	},
}
EOF

