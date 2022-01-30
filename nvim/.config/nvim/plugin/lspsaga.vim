" 'o' in finder to goto
nnoremap <silent><leader>sn :Lspsaga rename<CR>
nnoremap <silent><leader>sa :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><leader>s[ :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>s] :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent><leader>sf :lua vim.lsp.buf.definition()<CR>
" nnoremap <silent><leader>ff :lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>sr :lua vim.lsp.buf.references() <CR>
nnoremap <silent><leader>sh :lua vim.lsp.buf.hover() <CR>
nnoremap <silent><leader>sd :lua vim.diagnostic.open_float() <CR>

