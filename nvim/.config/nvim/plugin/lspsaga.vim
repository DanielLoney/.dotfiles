" 'o' in finder to goto
" nnoremap <silent><leader>sr :Lspsaga lsp_finder<CR>
" nnoremap <silent><leader>ss :Lspsaga signature_help<CR>
nnoremap <silent><leader>sn :Lspsaga rename<CR>
" nnoremap <silent><leader>sp :Lspsaga preview_definition<CR>
" nnoremap <silent><leader>sh :Lspsaga hover_doc<CR>
" nnoremap <silent><leader>sd :Lspsaga show_line_diagnostics<CR>
" nnoremap <silent><leader>sa :Lspsaga code_action<CR>
nnoremap <silent><leader>sa :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><leader>s[ :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>s] :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent><leader>sf :lua vim.lsp.buf.definition()<CR>
" nnoremap <silent><leader>ff :lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>sr :lua vim.lsp.buf.references() <CR>
nnoremap <silent><leader>sh :lua vim.lsp.buf.hover() <CR>
