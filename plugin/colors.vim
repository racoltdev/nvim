set termguicolors
let g:Hexokinase_highlighters=["background"]

colorscheme raspberry

match ExtraWhitespace /\s\+$/
augroup WhiteSpaceHighlight
	au BufWinEnter * match ExtraWhitespace /\s\+$/
	au BufEnter * match ExtraWhitespace /\s\+$/
	au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	au InsertLeave * match ExtraWhitespace /\s\+$/
	au BufWinLeave * call clearmatches()
	au TermEnter * match none
	au TermLeave * match ExtraWhitespace /\s\+$/
augroup END

lua << EOF
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
			[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
			[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
		},
	},
})
EOF

lua require'colorizer'.setup()
