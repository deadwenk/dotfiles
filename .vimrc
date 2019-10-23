" Plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-syntastic/syntastic'
Plug 'lifepillar/vim-mucomplete'
Plug 'takac/vim-hardtime'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-lua-ftplugin'

call plug#end()

" Color scheme
set t_Co=256
set t_ut=
colorscheme codedark

" Airline plugin
let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1

" Syntastic plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
""let g:syntastic_check_on_open = 1
""let g:syntastic_check_on_wq = 0
"let g:syntastic_check_on_open = 1
""let g:syntastic_lua_checkers = ["luac", "luacheck"]
""let g:syntastic_lua_luacheck_args = "--no-unused-args"

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set number		" Show the number of line
set clipboard=unnamed	" Disabling default vim clipboard (will use system)
set scrolloff=4 	" Keep a minimum buffer of n-lines before or after current cursor line
set hlsearch 		" Search highlight
set tabstop=2
set softtabstop=0 noexpandtab
set shiftwidth=2
set expandtab
