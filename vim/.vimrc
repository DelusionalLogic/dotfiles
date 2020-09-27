let mapleader=","       " leader is comma
let maplocalleader=",," " localleader is comma comma

if &compatible
	set nocompatible               " Be iMproved
endif

call plug#begin('~/.vim/plugged')

" Colors
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'

" Notes
Plug 'xolox/vim-notes'

" Syntax
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'Shougo/neoinclude.vim'
" Plug 'scrooloose/syntastic'

" Make
" Plug 'neomake/neomake'

" XML
Plug 'othree/xml.vim'

"LaTeX
Plug 'lervag/vimtex', {'for': 'tex'}

" GLSL
Plug 'tikhomirov/vim-glsl'

"Rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}

"Love2D
Plug 'alols/vim-love-efm'

"Python
Plug 'vimjas/vim-python-pep8-indent', {'for': 'python'}

"Lua
Plug 'xolox/vim-misc' | Plug 'xolox/vim-lua-ftplugin'

"Racket/Scheme
Plug 'MicahElliott/vrod'
" Plug 'wlangstroth/vim-racket'
Plug 'Shougo/vimshell'

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Interface
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'tpope/vim-commentary'
Plug 'dhruvasagar/vim-table-mode'

" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'

" Speed
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'

" Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Vimperator
Plug 'vimperator/vimperator.vim'

" Fun icons
Plug 'ryanoasis/vim-devicons'

let tq_enabled_backends=["datamuse_com"]
Plug 'ron89/thesaurus_query.vim'

" Ledger
Plug 'ledger/vim-ledger'

" Required:
call plug#end()

filetype plugin indent on

" Vim man plugin
"runtime! ftplugin/man.vim

augroup FileSpecific
	autocmd!
	"Markdown
	autocmd BufRead,BufNewFile *.md set filetype=markdown
	autocmd FileType markdown setlocal spell textwidth=72

	"Git commits
	autocmd FileType gitcommit setlocal textwidth=72
	autocmd FileType gitcommit setlocal spell
	autocmd FileType gitcommit set completeopt+=preview

	"CSS
	autocmd FileType css,scss,sass setlocal iskeyword+=-

	" Fugitive
	autocmd User fugitive
			\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
			\   nnoremap <buffer> .. :edit %:h<CR> |
			\ endif
	autocmd BufReadPost fugitive://* set bufhidden=delete

	autocmd FileType tex setlocal spell textwidth=72

augroup END

set formatoptions=qrn1jt

let g:tex_flavor='latex' "Default to latex filetype
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'

set gdefault "Default to global substitution on line

set showcmd "Show partially typed command

syntax enable "enable syntax highlighting!

if !has('nvim')
	set ttyfast "I'm on a modern computer damn it. My tty is fast
endif

"Pretty stuff
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

set synmaxcol=800

"Trailing whitespace
augroup trailing
	au!
	au InsertEnter * :set listchars-=trail:⌴
	au InsertLeave * :set listchars+=trail:⌴
augroup END

set modeline

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

set ignorecase
set smartcase
set incsearch "search as you type
set hlsearch "highlight matches
set magic

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" print highlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
noremap <F12> :syntax sync fromstart<CR>


set foldenable "enable folding
set foldlevelstart=10 "unfold must stuff
set foldnestmax=10 "no folds over 10
"open/close folder
nnoremap <space> za

set foldmethod=marker "Fold based on indentation

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

"Save as root with w!!
cnoremap w!! w !sudo tee %

"Lets use ranger to browse all the files why dont we
nnoremap - :call OpenRanger()<CR>

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

"Stop creating all those stupid files vim
set nobackup
set nowritebackup
set noswapfile

"Omnicomplete settings
set complete+=kspell
set completeopt=longest,preview,menuone,noselect

"Map tab to down and up when in omnicomplete
function! TryExpand()
	call UltiSnips#ExpandSnippetOrJump()
	return g:ulti_expand_or_jump_res
endfunction
inoremap <expr> <CR> pumvisible() ? "\<C-R>=TryExpand() ? \"\" : \"\<C-y>\"\<CR>" : "\<C-g>u\<CR>"

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
	au!
	au BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\     execute 'normal! g`"zvzz' |
				\ endif
augroup END

" toggle between number and relativenumber
function! ToggleNumber()
	if(&relativenumber == 1)
		set norelativenumber
		set number
	else
		set relativenumber
	endif
endfunc

nnoremap <leader>ll :call ToggleNumber()<CR>

" Convenient ncommand to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

highlight VertSplit ctermfg=244 ctermbg=NONE cterm=bold

set numberwidth=5
set nu

let g:airline_powerline_fonts=1
" let g:airline_theme='base16'
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
set noshowmode
set laststatus=2 "Always display the statusline

"GitGutter colors {{{
highlight clear SignColumn
highlight GitGutterChange ctermbg=NONE ctermfg=Yellow
highlight GitGutterAdd ctermbg=NONE ctermfg=DarkGreen
highlight GitGutterDelete ctermbg=NONE ctermfg=Red
highlight GitGutterChangeDelete ctermbg=NONE ctermfg=Blue
let g:gitgutter_max_signs = 1000

" }}}

"Shell command to open cmd output in scratch buffer
function! s:ExecuteInShell(command)
	let command = join(map(split(a:command), 'expand(v:val)'))
	let winnr = bufwinnr('^' . command . '$')
	silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
	setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
	echo 'Execute ' . command . '...'
	silent! execute 'silent %!'. command
	silent! execute 'resize ' . line('$')
	silent! redraw
	silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
	silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
	echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

set background=dark
colorscheme nord

" EasyMotion {{{
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map s <Plug>(easymotion-overwin-f2)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_smartcase = 1 " US layout

" }}}

" Vim-Go {{{
" disable coc.nvim feature

" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" }}}

" coc.nvim {{{

set updatetime=300

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger = "<leader>e"

let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" let g:UltiSnipsUsePythonVersion = 3

"let g:UltiSnipsSnippetsDir="~/.config/nvim/ultisnips"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "ultisnips"]

" }}}

" Neomake {{{
let g:neomake_error_sign = {
			\ 'text': '>>',
			\ 'texthl': 'ErrorMsg',
			\ }
hi MyWarningMsg ctermbg=3 ctermfg=0
let g:neomake_warning_sign = {
			\ 'text': '>>',
			\ 'texthl': 'MyWarningMsg',
			\ }

let g:neomake_rust_enabled_makers = ['cargo']

augroup my_neomake_cmds
	autocmd!
	" Have neomake run cargo when Rust files are saved.
	" autocmd BufWritePost *.rs Neomake cargo
augroup END

" }}}

" Racket {{{
"
let g:vimshell_enable_start_insert = 0

" }}}

" Unite.vim {{{
nnoremap <C-p> :Unite -auto-resize -start-insert -buffer-name=Files file<CR>
nnoremap <LocalLeader>b :Unite -auto-resize -buffer-name=Buffers buffer<CR>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
	" Overwrite settings.
	nmap <buffer> <ESC> <Plug>(unite_exit)

	imap <buffer> jj      <Plug>(unite_insert_leave)
	"imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

	imap <buffer><expr> j unite#smart_map('j', '')
	imap <buffer> <TAB>   <Plug>(unite_select_next_line)
	imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
	imap <buffer> '     <Plug>(unite_quick_match_default_action)
	nmap <buffer> '     <Plug>(unite_quick_match_default_action)
	imap <buffer><expr> x
				\ unite#smart_map('x', "\<Plug>(unite_quick_match_jump)")
	nmap <buffer> x     <Plug>(unite_quick_match_jump)
	nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
	imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
	nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
	nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
	imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
	nnoremap <silent><buffer><expr> l
				\ unite#smart_map('l', unite#do_action('default'))

	let unite = unite#get_current_unite()
	if unite.profile_name ==# 'search'
		nnoremap <silent><buffer><expr> r     unite#do_action('replace')
	else
		nnoremap <silent><buffer><expr> r     unite#do_action('rename')
	endif

	if unite.buffer_name ==# 'Buffers'
		nnoremap <silent><buffer><expr> dd    unite#do_action('wipeout')
	endif

	nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
	nnoremap <buffer><expr> S      unite#mappings#set_current_sorters(
				\ empty(unite#mappings#get_current_sorters()) ?
				\ ['sorter_reverse'] : [])

	" Runs "split" action by <C-s>.
	imap <silent><buffer><expr> <C-s>     unite#do_action('split')
endfunction

let g:unite_source_history_yank_enable = 1
nnoremap <LocalLeader>y :Unite -no-split -start-insert -auto-resize -buffer-name=Yank_History history/yank<CR>
nnoremap ff :Unite grep:. -no-split -start-insert -auto-resize -wrap <CR>

let g:unite_source_grep_command = 'rg'
let g:unite_source_grep_default_opt = '--hidden --no-heading --vimgrep -S'
let g:unite_source_grep_recursive_opt = ''
" }}}

" Vim-Notes {{{
let g:notes_directories = ['~/BitTorrent Sync/notes', '~/Documents/Notes']
" }}}

" Java {{{
" Create class

function! g:JavaSourcePackage() abort
    let path = expand("%:.:h")
    let package_path = substitute(path, ".*java/", "", "")

    return substitute(package_path, "/", ".", "g")
endfunction

function! g:ClassFromNone() abort
    let package = JavaSourcePackage()

    let package = input("New Class: ", package)
endfunction

function! g:ClassFromName(name) abort
    let package = JavaSourcePackage() . "." . a:name

    let package = input("New Class: ", package)
endfunction

" }}}
