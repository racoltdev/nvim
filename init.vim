let g:python3_host_prog='/home/andy/.venv/bin/python'

call plug#begin()

" Hex code colors
Plug 'norcalli/nvim-colorizer.lua'

Plug 'neovim/nvim-lspconfig'

" venv picker
Plug 'AckslD/swenv.nvim'

" Lua tools for swenv
Plug 'nvim-lua/plenary.nvim'

" menu tool for swenv
Plug 'stevearc/dressing.nvim'

call plug#end()

lua << eof
	require("swenv").setup({
		venvs_path = vim.fn.expand('~/venvs')
	})
	local lspconf=require('lspconfig')
	local python_root_files = {
		'WORKSPACE', -- added for Bazel; items below are from default config
		'pyproject.toml',
		'setup.py',
		'setup.cfg',
		'requirements.txt',
	 	'Pipfile',
		'pyrightconfig.json',
		'.git',
		'.venv'
	}
	lspconf.pyright.setup {
		on_attach = on_attach,
		root_dir = lspconf.util.root_pattern(unpack(python_root_files)),
		-- These lines are only needed if I stop using swenv
		python = {venvPath = "~/venvs"},
		venv = "user",
	}
	require('swenv.api').pick_venv()
