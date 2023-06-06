" function! s:GetRoot()
" 	" Assumes root will always have .git. This could be improved
" 	let l:dir = finddir('.git/..', expand('%:p:h').';')
" 	return l:dir
" endfunc
" 
" function! s:GetCacheLoc()
" 	let l:dir = s:GetRoot()
" 	let l:cacheLoc = l:dir . "/.cachedVenv"
" 	:echo "Reading cache from " . l:cacheLoc
" 	return l:cacheLoc
" endfunc
" 
" function! s:GetCachedVenv()
" 	let l:cacheLoc = s:GetCacheLoc()
" 	let l:cache = findfile(l:cacheLoc, './')
" 	if l:cache == ""
" 		execute "!touch " . l:cacheLoc
" 		let l:cache = [""]
" 	else
" 		let l:cache = readfile(l:cacheLoc)
" 		if l:cache == []
" 			let l:cache = [""]
" 		endif
" 	endif
" 	return l:cache
" endfunc
" 
" function! AutoVenv()
" 	let l:cached = s:GetCachedVenv()[0]
" 	let l:currentVenv = ""
" 	if l:cached == ""
" 		lua require("swenv.api").pick_venv()
" 	else
" 		setenv('VIRTUAL_ENV', l:cached)
" 	endif
" endfunc
" 
" function! s:SwitchVenv()
" 	
" endfunc
" 
" command! Venv call s:GetCachedVenv()
" 
" autocmd VimEnter *.py call AutoVenv()

lua require('swenv.api').pick_venv()

