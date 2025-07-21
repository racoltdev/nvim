function! s:RestartLsp()
	if (&filetype == "cs")
		:OmniSharpRestartServer
	else
		:LspRestart
	endif
	echo "Restarted LSP"
endfunc

function! s:SetAutoReload(flag)
	let l:flag = tolower(a:flag[0])
	if (l:flag == "0" || l:flag == "false")
		au! autolsp
	elseif (l:flag == "1" || l:flag == "true")
		au! autolsp
		au autolsp FocusGained * call s:RestartLsp()
	else
		echo "Unknown argument. Expected true or false"
	endif
endfunc

augroup autolsp
	au!
	au FocusGained * call s:RestartLsp()
augroup END

command! -nargs=1 AutoReload call s:SetAutoReload(<f-args>)
