set nocompatible              " be iMproved, required

let mapleader = " " " map leader to Space
" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

Plug 'ambv/black'

Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'

Plug 'williamboman/mason.nvim'

" gc<motion> to commonet
" gcc to comment one line
Plug 'tpope/vim-commentary'

set completeopt=menuone,noselect
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'creativenull/diagnosticls-configs-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
"Plug 'nvim-treesitter/playground'

" TODO look at this
" Debugger Plugins
" Plug 'puremourning/vimspector'
" let g:vimspector_enable_mappings = 'HUMAN'
" packadd! vimspector

Plug 'szw/vim-maximizer'
let g:maximizer_set_default_mapping = 0
nnoremap <leader>mm :MaximizerToggle!<CR>

Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'tpope/vim-fugitive'

Plug 'tmhedberg/SimpylFold'

"Colorschemes
Plug 'morhetz/gruvbox'

" Elixir syntax
Plug 'elixir-editors/vim-elixir'
" dirty hack
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex set filetype=eelixir

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call plug#end()

lua require("danielloney")

nnoremap <leader>sv :source $MYVIMRC<CR>

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

" Python Encoding
au BufRead,BufNewFile *.py,*.pyw
    \ set encoding=utf-8

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" From ThePrimagen <3
augroup no_whitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
