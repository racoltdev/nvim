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
		"au autolsp BufEnter *.cs call s:SetAutoReload(1)
	elseif (l:flag == "1" || l:flag == "true")
		au! autolsp
		"au autolsp BufEnter *.cs call s:SetAutoReload(1)
		au autolsp FocusGained * call s:RestartLsp()
	else
		echo "Unknown argument. Expected true or false"
	endif
endfunc

augroup autolsp
	au!
	"au BufEnter *.cs call s:SetAutoReload(1)
augroup END

command! -nargs=1 AutoReload call s:SetAutoReload(<f-args>)
