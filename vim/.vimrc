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

" Colors
NeoBundle 'flazz/vim-colorschemes'

" Syntax
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
NeoBundle 'jrozner/vim-antlr'

" Interface
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'dhruvasagar/vim-vinegar'
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tpope/vim-commentary'

" Integration
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'tpope/vim-dispatch'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


augroup FileSpecific
	autocmd!
	"Markdown
	autocmd BufRead,BufNewFile *.md set filetype=markdown
	autocmd FileType markdown setlocal spell
	autocmd BufRead,BufNewFile *.md setlocal textwidth=80

	"Git commits
	autocmd FileType gitcommit setlocal textwidth=72
	autocmd FileType gitcommit setlocal spell

	"CSS
	autocmd FileType css,scss,sass setlocal iskeyword+=-

	" Fugitive
	autocmd User fugitive 
				\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
				\   nnoremap <buffer> .. :edit %:h<CR> |
				\ endif
	autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

set gdefault "Default to global substitution on line

set laststatus=2 "Always display the statusline

set showcmd "Show partially typed command

syntax enable "enable syntax highlighting!

set ttyfast "I'm on a modern computer damn it. My tty is fast

set scrolloff=7 "7 Lines to the cursor

set tabstop=4 "set tab size
set softtabstop=4 "set spaces in tabs
set shiftwidth=4 "once again tabstop

set showtabline=1 "Show tab lines when it's at least two deep

set smarttab "tab inserts indents instead of tab char
set autoindent

set hidden "Let you hide buffers with changes

set number "show gutter with numbers
set cursorline "highlight current line

filetype indent on "file specific indentation rules

set wildmenu "visual command menu

set lazyredraw "only redraw when needed

set showmatch "show matching parens
set matchtime=15

set ignorecase
set smartcase
set incsearch "search as you type
set hlsearch "highlight matches
set magic

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

" Better move between splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap <CR><CR> i<CR><ESC>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Copy/paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>yy "+yy
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

cnoremap w!! w !sudo tee %

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

set nobackup
set nowritebackup
set noswapfile

set complete+=kspell
set completeopt=longest,menuone,noselect

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
			\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
			\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" toggle between number and relativenumber
function! ToggleNumber()
	if(&relativenumber == 1)
		set norelativenumber
		set number
	else
		set relativenumber
	endif
endfunc

nnoremap <leader>l :call ToggleNumber()<CR>

" Convenient ncommand to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
			\ | wincmd p | diffthis
endif

colorscheme 0x7A69_dark
highlight VertSplit ctermfg=244 ctermbg=NONE cterm=bold

set numberwidth=5
highlight LineNr term=bold cterm=NONE ctermfg=Black ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set nu

let g:airline_powerline_fonts=1
let g:airline_THEME="Badwolf"
set noshowmode

highlight clear SignColumn
highlight GitGutterChange ctermbg=NONE ctermfg=Yellow 
highlight GitGutterAdd ctermbg=NONE ctermfg=DarkGreen 
highlight GitGutterDelete ctermbg=NONE ctermfg=Red 
highlight GitGutterChangeDelete ctermbg=NONE ctermfg=Blue 
