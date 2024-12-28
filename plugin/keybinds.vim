" Clear search highlighting
nnoremap <esc><esc> :noh<return>

function! s:ChangeVenv()
	lua require("swenv.api").pick_venv()
endfunc
command! ChangeVenv call s:ChangeVenv()

function! s:CallTest()
	if (&filetype == "python")
		:Pytest file -v
	else
		echo "File type not configured"
	endif
endfunc
command! Test call s:CallTest()

command! Init e ~/.config/nvim/init.vim

" Continue Comment block only on <Alt-Enter>
function! CommentEnter()
	let l:curline = getline(line('.'))
	let l:striptabs = split(curline, '\s\+')[0]
	let l:primo =strpart(striptabs, 0, 2)
	if (l:primo == "\/\*")
		let l:primo = " \*"
	elseif (strpart(l:primo, 1, 2) == "\s")
		let l:primo = strpart(l:primo, 0, 1)
	endif
	return "\<CR>" . l:primo . "\<Space>"
endfunction
imap <expr> <A-CR> CommentEnter()

" Map <Alt-Backspace> to delete previous word
inoremap <A-BS> <C-\><C-O>dB

"Visual newline insertion
inoremap <C-=> \R

" Auto complete using parenthesis
function! CloseBracket()
	if (col('.') > 2)
		let l:currChar = strcharpart(getline('.')[col('.') - 3:], 0, 2)
		if (l:currChar == "\/\*")
			return "\*\/"
		endif
	endif
		let l:currChar = strcharpart(getline('.')[col('.') - 2:], 0, 1)
	echom l:currChar
		if (l:currChar == "(")
			let l:returnChar = ")"
		elseif (l:currChar == "[")
			let l:returnChar = "]"
		elseif (l:currChar == "{")
			let l:returnChar = "}"
		elseif (l:currChar == "<")
			let l:returnChar = ">"
		elseif (l:currChar == "\"")
			let l:returnChar = "\""
		elseif (l:currChar == "\'")
			let l:returnChar = "\'"
 		else
 			let l:returnChar = l:currChar
		endif
	return l:returnChar
endfunction

function! CloseWord()
	let l:closing = CloseBracket()
	return "\<Esc>ea" . l:closing
endfunc

function! CloseLine()
	let l:closing = CloseBracket()
	return "\<Esc>A" . l:closing
endfunc

inoremap <expr> <A-.> CloseWord()
inoremap <expr> <A-/> CloseLine()

function! MoveSelection(start, end, dir)
	:echom a:start . " " . a:end . " " . a:dir
	return "yp"
endfunc

" Easily move a group of lines once selected
vnoremap <expr> <A-j> MoveSelection("'<","'>", 1)
vnoremap <A-k> :m '<-2<CR>gv=gv

" Insert newline without entering Insert
nnoremap <A-CR> o<Esc>

" Ctrl Space opens completeion menu
inoremap <C-Space> <C-n>

" Enter selects highlighted menu item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Tab cycles autocomplete options if visible
imap <expr> <TAB> pumvisible() ? "\<C-Space>" : "\<TAB>"

" Cycles backwards on shift tab
imap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Go to definition with omnisharp/Csharp
autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_find_implementations)

" Preview definition with omnsiharp/Csharp
autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_implementation)

" Go back to previous cursor position before a jump
map <C-b> ``

lua << eof
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	

