"	NvimLightBlue
"	NvimLightCyan

let g:colors_name = 'raspberry'

hi VirtText guifg=#e0d9f6  guibg=#002020 gui=italic

" Highlight extra whitespace
hi ExtraWhitespace guibg=#b51346
" Suggestions Box
hi Pmenu guifg=#e000ce guibg=#000000
hi PmenuSel guifg=#e00078 guibg=#2b272a
hi PmenuSBar guibg=#000000
hi PmenuThumb guibg=#2b272a

" Overall background
hi Normal guibg=#190d19 guifg=#e8f5e8

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
hi csAccessModifier guifg=#dd60de
hi csModifier guifg=#dd60de
hi csClass guifg=#dd60de
hi Parameter guifg=NvimLightBlue
hi Field guifg=#b5b1e2
hi Class guifg=#d85390

let g:OmniSharp_highlight_groups = {
	\ 'ParameterName': 'Parameter',
	\ 'FieldName': 'Field',
	\ 'ClassName': 'Class'
\}

hi DiagnosticSignError ctermfg=9 guifg=NvimLightRed guibg=#002020
hi DiagnosticSignWarn ctermfg=11 guifg=NvimLightYellow guibg=#002020

