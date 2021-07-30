" nnoremap <leader>mm :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Continue()
nnoremap <leader>de :call vimspector#Reset()

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>dr <Plug>VimspectorRestart

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
