fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun
" nnoremap <leader>mm :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Continue()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dgc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dgo :call GotoWindow(g:vimspector_session_windows.output)<CR>

nmap <leader>dj <Plug>VimspectorStepInto
nmap <leader>dl <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>dr <Plug>VimspectorRestart

nmap <leader>dcc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
