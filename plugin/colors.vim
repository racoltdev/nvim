" Custom Colors!
function! s:my_colors_setup() abort
	set termguicolors
	let g:Hexokinase_highlighters=["background"]

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
	hi Todo guibg=#37de37
	hi LineNr guifg=#e0d9f6 gui=italic
	hi LspCxxHlGroupNamespace guifg=#cfac13 gui=bold
	hi LspCxxHlGroupEnumConstant guifg=#d442f5
	hi NonText guifg=#e0d9f6
endfunction

augroup colorscheme_coc_setup
    autocmd!
    autocmd ColorScheme * call s:my_colors_setup()
augroup END

colorscheme default

lua require'colorizer'.setup()
