" Custom Colors!
function! s:my_colors_setup() abort
	set termguicolors
	let g:Hexokinase_highlighters=["background"]

"	NvimLightBlue
"	NvimLightCyan

	hi VirtText guifg=#e0d9f6  guibg=#002020 gui=italic

	" Highlight extra whitespace
	hi ExtraWhitespace guibg=#b51414
 	match ExtraWhitespace /\s\+$/
	au BufWinEnter * match ExtraWhitespace /\s\+$/
	au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	au InsertLeave * match ExtraWhitespace /\s\+$/
 	au BufWinLeave * call clearmatches()

	" Suggestions Box
	hi Pmenu guifg=#e000ce guibg=#000000
	hi PmenuSel guifg=#e00078 guibg=#2b272a
	hi PmenuSBar guibg=#000000
	hi PmenuThumb guibg=#2b272a

	" Overall background
	hi Normal guibg=#170a17 guifg=#e8f5e8

	" Syntax Highlighting
	hi Comment guifg=#e0d9f6 gui=italic
	hi Statement guifg=#cfac13
	hi String guifg=#24b576 gui=italic
	hi Type guifg=#ff80ff
	hi Constant guifg=#e31b64
	hi Number guifg=#e31b64
	hi Boolean guifg=#e31b64
	hi Todo guibg=#37de37 guifg=#000000 gui=bold
	hi LineNr guifg=#e0d9f6 guibg=#002020 gui=italic
	hi LspCxxHlGroupNamespace guifg=#cfac13 gui=bold
	hi LspCxxHlGroupEnumConstant guifg=#d442f5
	hi NonText guifg=#e0d9f6
	hi Identifier guifg=#e8f5e8
	hi Special guifg=#4cefef
	hi Function guifg=#4cefef
"	I was hoping these would change cpp and python variables too
"	hi! def link @variable Identifier
"	hi! def link cUserCont Identifier
"	hi! def link pythonAttribute Identifier

	hi csAccessModifier guifg=#4cefef
	hi DiagnosticSignError ctermfg=9 guifg=NvimLightRed guibg=#002020
	hi DiagnosticSignWarn ctermfg=11 guifg=NvimLightYellow guibg=#002020
	sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
	sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn

endfunction

augroup colorscheme_coc_setup
    autocmd!
    autocmd ColorScheme * call s:my_colors_setup()
augroup END

colorscheme default

lua require'colorizer'.setup()
