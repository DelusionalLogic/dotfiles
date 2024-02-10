require('lspconfig')['rust_analyzer'].setup{
	cmd = {"rustup", "run", "stable", "rust-analyzer"},
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {}
	}
}

local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>mr', ":Make run<CR>", bufopts)
