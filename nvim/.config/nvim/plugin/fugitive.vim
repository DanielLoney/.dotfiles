nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" gI to add to gitignore
" = to see inline difference
" <any number>gI to add to gitignore

function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Git
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()
nmap <silent><F3> :ToggleGStatus<CR>
