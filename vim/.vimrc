let mapleader=","       " leader is comma
let maplocalleader=",," " localleader is comma

if &compatible
	set nocompatible               " Be iMproved
endif

call plug#begin('~/.vim/plugged')

" Colors
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'

" Notes
Plug 'xolox/vim-notes'

" Syntax
"Plug 'Valloric/YouCompleteMe', { 'do': 'python2.7 ./install.py --all' }
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neoinclude.vim'
Plug 'scrooloose/syntastic'

" Make
Plug 'neomake/neomake'

"PHP
Plug 'm2mdas/phpcomplete-extended', {'for': 'php'}

"LaTeX
"Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'delusionallogic/vimtex', {'for': 'tex'}

"Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

"Love2D
Plug 'alols/vim-love-efm'

"Python
Plug 'zchee/deoplete-jedi'

"Lua
Plug 'xolox/vim-misc' | Plug 'xolox/vim-lua-ftplugin'

"C and C++
Plug 'zchee/deoplete-clang'

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
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Vimperator
Plug 'vimperator/vimperator.vim'

"Code review (diffscuss)
Plug 'hut8labs/diffscuss', {'rtp': 'diffscuss.vim/'}

Plug 'junegunn/vim-emoji'
Plug 'rhysd/unite-emoji.vim'

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
let g:vimtex_latexmk_progname = 'nvr'
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
set completeopt=longest,menuone,noselect,preview

"Map tab to down and up when in omnicomplete
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
			\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
			\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

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
let g:airline_theme='base16'
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
colorscheme base16-flat-mod

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

"Deoplete {{{

let g:deoplete#enable_at_startup=1
inoremap <silent><expr> <Tab>
		\ pumvisible() ? "\<C-n>" :
		\ "\<Tab>"

if !exists('g:deoplete#omni_patterns')
	let g:deoplete#omni_patterns = {}
endif

" let g:deoplete#omni_patterns.tex =
" 			\ '\v\\%('
" 			\ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
" 			\ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
" 			\ . '|hyperref\s*\[[^]]*'
" 			\ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
" 			\ . '|%(include%(only)?|input)\s*\{[^}]*'
" 			\ . ')\m'

if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
if !exists('g:deoplete#omni#functions')
	let g:deoplete#omni#functions = {}
endif
let g:deoplete#omni#input_patterns.tex =
			\   '\\(?:'
			\  .   '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
			\  .  '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
			\  .  '|hyperref\s*\[[^]]*'
			\  .  '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
			\  .  '|(?:include(?:only)?|input)\s*\{[^}]*'
			\  .')'

" }}}

" Lua {{{
	let g:lua_check_syntax = 0
	let g:lua_complete_omni = 1
	let g:lua_complete_dynamic = 0
	let g:lua_define_completion_mappings = 0

	" let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'
	let g:deoplete#omni#functions.lua = 'xolox#lua#completefunc'
" }}}

"Deoplete-clang {{{

let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

let g:deoplete#sources#clang#flags = [
	\ "-I", "/usr/include/gio-unix-2.0/",
	\ "-I", "/usr/include/glib-2.0/",
	\ "-I", "/usr/include/glib-2.0/include",
	\]

	" \ system("pkg-config --cflags gio-unix-2.0"),
" }}}

"PHPcompleter-extended {{{
"
let g:phpcomplete_index_composer_command = 'composer'
let g:deoplete#omni#input_patterns.php = '[^. \t]->|[a-zA-Z_]\w*::|(?:new|use|extends|implements)\s|(?:\$)'

"}}}

"Vim-Racer {{{

let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH="/usr/src/rust/src/"

let g:racer_experimental_completer = 1

" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
	let snippet = UltiSnips#ExpandSnippetOrJump()
	if g:ulti_expand_or_jump_res > 0
		return snippet
	else
		return "\<CR>"
	endif
endfunction
inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"

let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"let g:UltiSnipsSnippetsDir="~/.config/nvim/ultisnips"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "ultisnips"]

" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
  autocmd BufWritePost *.rs Neomake! cargo
augroup END

" }}}

" Racket {{{
"
let g:syntastic_enable_racket_racket_checker = 1
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

nnoremap <F9> :Unite -auto-resize -buffer-name=Unite_Menu menu<CR>
inoremap <F9> :Unite -auto-resize -buffer-name=Unite_Menu menu<CR>

nnoremap <C-L> :Unite -no-split -auto-resize -buffer-name=Lines line<CR>
inoremap <C-L> :Unite -no-split -auto-resize -buffer-name=Lines line<CR>

" }}}

nnoremap <C-e> :Unite -auto-resize -start-insert -buffer-name=Emoji emoji<CR>

" Vim-Notes {{{
 let g:notes_directories = ['~/BitTorrent Sync/notes', '~/Documents/Notes']
" }}}
