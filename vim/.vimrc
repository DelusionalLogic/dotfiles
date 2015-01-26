let mapleader=","       " leader is comma

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible "Be iMproved
  " Required:
  set runtimepath+=/home/delusional/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/delusional/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'Valloric/YouCompleteMe'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

set laststatus=2

syntax enable "enable syntax highlighting!

set tabstop=4 "set tab size
set softtabstop=4 "set spaces in tabs
set shiftwidth=4 "once again tabstop

set smarttab "tab inserts indents instead of tab char

set hidden "Let you hide buffers with changes

set number "show gutter with numbers
set cursorline "highlight current line

filetype indent on "file specific indentation rules

set wildmenu "visual command menu

set lazyredraw "only redraw when needed

set showmatch "show matching parens

set incsearch "search as you type
set hlsearch "highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

set foldenable "enable folding
set foldlevelstart=10 "unfold must stuff
set foldnestmax=10 "no folds over 10
 "open/close folder
nnoremap <space> za

set foldmethod=indent "Fold based on indentation

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

set nobackup
set noswapfile

" toggle between number and relativenumber
function! ToggleNumber()
	if(&relativenumber == 1)
		set norelativenumber
		set number
	else
		set relativenumber
	endif
endfunc

" Convenient ncommand to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
			\ | wincmd p | diffthis
endif

set numberwidth=6
highlight LineNr term=bold cterm=NONE ctermfg=Black ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set nu

let g:airline_powerline_fonts=1

highlight clear SignColumn
highlight GitGutterChange ctermbg=NONE ctermfg=Yellow 
highlight GitGutterAdd ctermbg=NONE ctermfg=DarkGreen 
highlight GitGutterDelete ctermbg=NONE ctermfg=Red 
highlight GitGutterChangeDelete ctermbg=NONE ctermfg=Blue 
