let mapleader=","       " leader is comma
let maplocalleader=",," " localleader is comma comma

if &compatible
	set nocompatible               " Be iMproved
endif

call plug#begin('~/.vim/plugged')

" Colors
Plug 'arcticicestudio/nord-vim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovim/nvim-lspconfig'

" Debugger stuff
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/cmp-dap'

" Snippets (required for nvim-cmp)
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" XML
Plug 'othree/xml.vim'

" GLSL
Plug 'tikhomirov/vim-glsl'

"Rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}

"Love2D
Plug 'alols/vim-love-efm'
Plug 'davisdude/vim-love-docs'

"Python
Plug 'vimjas/vim-python-pep8-indent', {'for': 'python'}

"Lua
Plug 'xolox/vim-misc' | Plug 'xolox/vim-lua-ftplugin'

" Interface
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

Plug 'vim-airline/vim-airline'
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

set gdefault "Default to global substitution on line
set showcmd "Show partially typed command

syntax enable "enable syntax highlighting!
set synmaxcol=3000

if !has('nvim')
	set ttyfast "I'm on a modern computer damn it. My tty is fast
endif

"Pretty stuff
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

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

set foldmethod=marker "Fold based on indentation

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Better move between splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

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

"Stop creating all those stupid files vim
set nobackup
set nowritebackup
set noswapfile

"Omnicomplete settings
set complete+=kspell
set completeopt=longest,preview,menuone,noselect

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
command! -nargs=+ -complete=shellcmd Shell call s:ExecuteInShell(<q-args>)

let g:nord_uniform_status_lines = 0
set background=dark
colorscheme nord

" EasyMotion {{{
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Without these mappings, `n` & `N` work fine. (These mappings just provide
" different highlight method and have some other features)
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

" LSP common {{{
lua << LEND
capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end
LEND
" }}}

" C {{{
lua << LEND
require'lspconfig'.clangd.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
LEND
" }}}

" nvim-cmp {{{
lua << LEND
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Cmp debugger integration
require("cmp").setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})
LEND
" }}}

" Nvim-Dap configuration for lua {{{
lua << LEND
local dap = require('dap')
dap.adapters.lldebugger = {
  type = 'executable',
  command = '/usr/bin/local-lua-dbg',
  name = 'lldebugger'
}

dap.configurations.lua = {
  {
    type = 'lldebugger',
    request = 'launch',
    name = 'Launch Love2D',
    program = {
        command = "love",
    },
    args = {
        "."
    },
    scriptRoots = {
        "."
    },
    cwd = ".",
    workspacePath = ".",
  },
}
LEND
" }}}
