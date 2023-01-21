nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

function FugitiveToggle() abort
  try
    exe filter(getwininfo(), "get(v:val['variables'], 'fugitive_status', v:false) != v:false")[0].winnr .. "wincmd c"
  catch /E684/
    Git
  endtry
endfunction
nmap <silent><F3> <cmd>call FugitiveToggle()<CR>
