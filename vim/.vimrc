vim.g.mapleader = ","
vim.g.maplocalleader = ",,"

vim.opt.compatible = false

local platform_config = {
}

local ok, ns = pcall(require, 'platform_config')
if ok then
	ns(platform_config)
end

vim.cmd([[
call plug#begin('~/.vim/plugged')

"Colors
Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Language server support
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'

"Debugger
Plug 'mfussenegger/nvim-jdtls'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/cmp-dap'

"Rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}

"Python
Plug 'vimjas/vim-python-pep8-indent', {'for': 'python'}

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

"Interface
Plug 'francoiscabrol/ranger.vim'

Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-commentary'

"Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }

"Speed
Plug 'ggandor/leap.nvim'
Plug 'tpope/vim-surround'

"Integration
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

"Fun icons
Plug 'nvim-tree/nvim-web-devicons'

"Latex support
Plug 'lervag/vimtex'

" Required:
]])

vim.cmd([[
call plug#end()
]])

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.formatoptions = "trqn1j"
vim.opt.gdefault = true
vim.opt.showcmd = true
vim.cmd("syntax enable")

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

vim.opt.list=true
vim.opt.listchars="tab:▸ ,eol:¬,extends:❯,precedes:❮"

local trailing = vim.api.nvim_create_augroup("trailing", {clear = true})
vim.api.nvim_create_autocmd({"InsertEnter"}, {
	pattern = "*",
	group = trailing,
	callback = function(ev)
		vim.opt.listchars:remove("trail:⌴")
	end,
})
vim.api.nvim_create_autocmd({"InsertLeave"}, {
	pattern = "*",
	group = trailing,
	callback = function(ev)
		vim.opt.listchars:append("trail:⌴")
	end,
})

vim.opt.modeline = true
vim.opt.scrolloff = 7

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.showtabline = 1

vim.opt.smarttab = true
vim.opt.autoindent = true

vim.opt.hidden = true

vim.opt.numberwidth = 5
vim.opt.number = true
vim.opt.cursorline = true

vim.cmd("filetype plugin indent on")

vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.wildmenu = true
vim.opt.lazyredraw = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.magic = true

vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.foldmethod = "marker"

vim.opt.background = "dark"
do
	local theme = require("nordic")
	theme.setup({
		italic_comments = false,
		transparent = { bg = true, float = false },
		reduced_blue = true,
		on_highlight = function(highlights, C)
			highlights.Keyword = { fg = C.blue1 }
			highlights.Field = { link = "Normal" }
			highlights.IncSearch = { bg = C.orange.base, fg = C.bg_visual, underline = true, bold = false }
			highlights.Search = { bg = C.cyan.base, fg = C.bg_visual, underline = false, bold = false }
			highlights.CurSearch = { link = "Search" }
			highlights.Comment = { fg = C.red.base }
			highlights.Delimiter = { link = "Normal" }
			highlights.Cursor = { link = "Normal" }
			highlights.Macro = { link = "Normal" }
			highlights.MatchParen = { underline = false, bold = false }
			highlights["@operator"] = { link = "Function", }
		end,
		cursorline = {
			theme = "light",
		}
	})
	theme.load()
end

vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>", {desc = "Remove highlights"})

-- move vertically by visual line
vim.keymap.set("n", "j", "gj", {desc = "Go down"})
vim.keymap.set("n", "k", "gk", {desc = "Go up"})

vim.keymap.set("c", "w!!", "w !sudo tee %", {desc = "Save as root"})

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.live_grep, {})

require('gitsigns').setup()

-- Common LSP settings
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
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

-- LSP clangd settings
require('lspconfig').clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- nvim-cmp
do
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	cmp.setup {
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
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
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		}),
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		},
		enabled = function()
			return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
		end
	}

	cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = {
			{ name = "dap" },
		},
	})
end

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
	capabilities = capabilities,
}

require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
	capabilities = capabilities,
}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = {only = {"source.organizeImports"}}
		-- buf_request_sync defaults to a 1000ms timeout. Depending on your
		-- machine and codebase, you may want longer. Add an additional
		-- argument after params if you find that you have to write the file
		-- twice for changes to be saved.
		-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({async = false})
	end
})

require('leap').add_default_mappings(true)
require('lualine').setup({
	options = {
		theme = "nordic"
	}
})

vim.cmd([[
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
noremap <F12> :syntax sync fromstart<CR>
]])

-- Snippets

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
require("luasnip.loaders.from_snipmate").lazy_load()
vim.api.nvim_create_user_command("LuaSnipEdit", function(opts)
    require("luasnip.loaders").edit_snippet_files()
end, {})
vim.api.nvim_create_user_command("LuaSnipCreate", function(opts)
    require("luasnip.loaders").edit_snippet_files({
        extend = function(ft, paths)
            if #paths == 0 then
                return {
                    { "$CONFIG/" .. ft .. ".snippets", string.format("~/.config/nvim/snippets/%s.snippets", ft) },
                    { "$CONFIG/" .. ft .. ".lua", string.format("~/.config/nvim/snippets/%s.lua", ft) }
                }
            end

            return {}
        end
    })
end, {})
