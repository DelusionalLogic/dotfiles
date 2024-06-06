local format = vim.api.nvim_create_augroup('format', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	group = format,
	callback = function()
		vim.cmd("silent! !isort -m3 --force-grid-wrap=1 --trailing-comma <afile>")
	end
})
