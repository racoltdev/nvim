let g:python3_host_prog='/home/andy/venvs/usr/bin/python'

call plug#begin()

" Hex code colors
Plug 'norcalli/nvim-colorizer.lua'

Plug 'neovim/nvim-lspconfig'

" venv picker
Plug 'racoltdev/swenv.nvim'

" Lua tools for swenv
Plug 'nvim-lua/plenary.nvim'

" menu tool for swenv
Plug 'stevearc/dressing.nvim'

" LSP tool I only use for C#
Plug 'OmniSharp/omnisharp-vim'

" Linter tool that works with omnisharp. I only use for C#
Plug 'dense-analysis/ale'

call plug#end()

" Shouldn't be needed if dotnet installed
let g:OmniSharp_server_use_net6 = 1

" Only run linters I explicitly enable
let g:ale_linters_explicit = 1

" Enable linting only for csharp
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

lua << eof
--	swenv = require("swenv")
--	swenv.setup({
--		venvs_path = vim.fn.expand('~/venvs')
--	})
	local api = vim.api
	api.nvim_create_autocmd(
		"VimEnter",
		{
	 		pattern = {"*.py"},
	 		command = [[lua require('swenv.api').init()]]
	 	}
	)

	vim.lsp.enable('pyright')
