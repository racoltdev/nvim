let  $BASH_ENV = "$XDG_CONFIG_HOME/nvim/.bashrc"

" Get highlighting group of character under cursor
function! s:SynGroup()
	if (&filetype == 'cs')
		OmniSharpHighlightEcho
	else
    	let l:s = synID(line('.'), col('.'), 1)
    	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
	endif
endfun

command! HiGroup call s:SynGroup()

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

function! s:OpenConfig()
	:e ~/.config/nvim/init.vim
	:cd ~/.config/nvim/
endfunc

command! Config call s:OpenConfig()

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
" TODO for CloseLine, insert bracket before semicolon if it exists
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
	let l:lastChar = getline('.')[len(getline('.')) - 1]
	if (l:lastChar == ";")
		let l:command = "\<Esc>$\<BS>a"
	else
		let l:command = "\<Esc>A"
	endif
	return l:command . l:closing
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

" TODO OmniSharp-vim binds <C-x><C-o> to run its completions. Make that run with this keybind instead
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

autocmd FileType cs inoremap <buffer> <C-Space> <C-x><C-o>
autocmd FileType cs inoremap <buffer> <expr> <TAB> pumvisible() ? "\<Down>" : "\<TAB>"
autocmd FileType cs inoremap <buffer> <expr> <Esc> pumvisible() ? "\<Space>\<C-u>" : "\<Esc>"

" Go back to previous cursor position before a jump
map <C-b> ``

" Remap copy to system clipboard
vnoremap <C-c> "+y

map <S-r> :redo <Enter>

" Navigate splits
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <A-Tab> <C-w><S-w>
map <A-Esc> <C-w><C-w>

" Window splitting
map <C-r> <esc> :vsplit <Enter> <C-l> :e
map <C-d> <esc> :split <Enter> <C-j> :e

" Set all windows to same size
map == <C-w>=

" Fix for <A-w> not re-entering insert mode
function! Skipword(w)
	if (len(getline('.')) < 2)
		return "\<esc>j^i"
	else
		return "\<esc>l".a:w."i"
	endif
endfunc

" Jump words in insert mode
inoremap <expr> <A-w> Skipword("w")
inoremap <expr> <S-A-w> Skipword("W")
inoremap <S-A-b> <esc><S-b>i
inoremap <A-b> <esc>bi
inoremap <S-A-e> <esc><S-e>a
inoremap <A-e> <esc>ea
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

nnoremap ! :!

lua << eof
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	

