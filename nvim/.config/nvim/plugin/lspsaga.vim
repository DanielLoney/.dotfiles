" 'o' in finder to goto
nnoremap <silent><leader>sn :Lspsaga rename<CR>
nnoremap <silent><leader>sa <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><leader>s[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>s] <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent><leader>sf <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent><leader>ff <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>sr <cmd>lua vim.lsp.buf.references() <CR>
nnoremap <silent><leader>sh <cmd>lua vim.lsp.buf.hover() <CR>
nnoremap <silent><leader>sd <cmd>lua vim.diagnostic.open_float() <CR>
