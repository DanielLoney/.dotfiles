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


" gc<motion> to commonet
" gcc to comment one line
Plug 'tpope/vim-commentary'

Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
set completeopt=menuone,noselect

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/playground'

"TODO look at this
" Debugger Plugins
Plug 'puremourning/vimspector'
" TODO check maximizer F3 binding
"Plug 'szw/vim-maximizer'
Plug 'glepnir/lspsaga.nvim'
Plug 'tpope/vim-fugitive'

Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let b:SimpylFold_fold_docstring=0
set foldlevelstart=99

" Enable folding with "\"
nnoremap <Bslash> za

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

set exrc
set guicursor=a:blinkon100
set nu
set tabstop=2
set shiftwidth=4
set expandtab
set autoindent
set ignorecase
set smartcase
set list listchars=tab:>\ ,trail:-,eol:$
set so=8
set incsearch
set colorcolumn=80
set nowrap
set clipboard=unnamedplus
set number
set relativenumber
set noswapfile
"set termguicolors
" gruvbox
set t_Co=256
set bg=dark

" remap leader key

colorscheme gruvbox
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

lua << EOF
local lsp=require('lspconfig')

-- lsp.jedi_language_server.setup{}

require("lspconfig").pyright.setup {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}

lsp.diagnosticls.setup {
  filetypes = { "python" },
  init_options = {
    filetypes = {
      python = {"pylint"},
    },
    linters = {
      pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        args = {
          '--output-format',
          'text',
          '--score',
          'no',
          '--msg-template',
          [['{line}:{column}:{category}:{msg} ({msg_id}:{symbol})']],
          '%file',
        },
        offsetColumn = 1,
        formatLines = 1,
        formatPattern = {
          [[^(\d+?):(\d+?):([a-z]+?):(.*)$]],
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        securities = {
          informational = 'hint',
          refactor = 'hint',
          convention = 'info',
          warning = 'warning',
          error = 'error',
          fatal = 'error'
        },
        rootPatterns = {
          '.git',
          'pyproject.toml',
          'setup.py',
        },
      }
    },
  }
}
EOF

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
