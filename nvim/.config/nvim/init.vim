set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

Plug 'ambv/black'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-compe'
set completeopt=menuone,noselect

lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

Plug 'glepnir/lspsaga.nvim'
" TODO keybindings <leader> s<initial>


" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Git
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()
nmap <F3> :ToggleGStatus<CR>

Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let b:SimpylFold_fold_docstring=0
set foldlevelstart=99

" Enable folding with "\"
nnoremap <Bslash> za

"Colorschemes
Plug 'morhetz/gruvbox'
set t_Co=256
set bg=dark

" Elixir syntax
Plug 'elixir-editors/vim-elixir'
" dirty hack
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex set filetype=eelixir

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Ctrl-p for fzf GFiles
noremap <C-p> :GFiles<CR>
" Ctrl-a for fzf by string
noremap <C-a> :Ag<CR>

" All of your Plugins must be added before the following line
call plug#end()
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set nu
set tabstop=2
set shiftwidth=4
set expandtab
set autoindent
set list
set so=8
set incsearch
set colorcolumn=80
set nowrap
set clipboard+=unnamedplus
set number
set relativenumber

" remap leader key
let mapleader = " " " map leader to Space

colorscheme gruvbox


" Enable folding
"set foldmethod=indent
"set foldlevel=99

" Python Indentations
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

syntax on
"Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Python Encoding
au BufRead,BufNewFile *.py,*.pyw
    \ set encoding=utf-8

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


