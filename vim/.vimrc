set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.


" remap leader key
let mapleader = " " " map leader to Space

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
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
" Git ignore: <any-number>gI (capital) and then write it to gitignore

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion = 1

" Show file path
"set laststatus=2
"set statusline+=%F

" \ g-d : Go to function definitions
" \ g-r : Go to references
" Reminder: Ctrl-^ goes to last file you were in
noremap <leader>gd :YcmCompleter GoToDefinition<CR>
noremap <leader>gr :YcmCompleter GoToReferences<CR>

Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let b:SimpylFold_fold_docstring=0
set foldlevelstart=99

" Enable folding with "\"
nnoremap <Bslash> za


"Colorschemes
Plugin 'morhetz/gruvbox'
colorscheme gruvbox
set t_Co=256
set bg=dark

"Relative line numbers with current line shown
set number
set relativenumber

"ale
Plugin 'dense-analysis/ale'

" Elixir syntax
Plugin 'elixir-editors/vim-elixir'
" dirty hack
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex set filetype=eelixir

" FZF
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Ctrl-p for fzf GFiles
noremap <C-p> :GFiles<CR>
" Ctrl-a for fzf by string
noremap <C-a> :Ag<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

" Copy
nnoremap <c-c> "+y
" Paste is just control shift v

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

"powerline
set  rtp+=/home/daniel/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

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


