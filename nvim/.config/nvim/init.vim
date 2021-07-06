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
nnoremap <silent><c-t> :NERDTreeToggle<CR>
nnoremap <silent><c-n> :NERDTreeFocus<CR>

nnoremap <leader>nf :NERDTreeFind<CR>
let NERDTreeShowHidden=1


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

" Plug 'apalmer1377/factorus'

Plug 'glepnir/lspsaga.nvim'
" 'o' in finder to goto
nnoremap <silent><leader>sr :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ss :Lspsaga signature_help<CR>
nnoremap <silent><leader>sn :Lspsaga rename<CR>
nnoremap <silent><leader>sp :Lspsaga preview_definition<CR>
nnoremap <silent><leader>sh :Lspsaga hover_doc<CR>
nnoremap <silent><leader>sd :Lspsaga show_line_diagnostics<CR>

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
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

" Ctrl-p for fzf GFiles
noremap <C-p> :GFiles<CR>

function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

" Ctrl-f for fzf by string
nnoremap <c-f> :FZFLines<CR>

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
lsp.pyls.setup{
    settings = {
        -- comment out for flake8
        pyls = {
            plugins = {
                pylint = {
                    enabled = true,
                }
            }
        },
    }
}
EOF

"lua << EOF
"local lsp=require('lspconfig')

"lsp.jedi_language_server.setup{}

"lsp.diagnosticls.setup {
"  filetypes = { "python" },
"  init_options = {
"    filetypes = {
"      python = {"pylint"},
"    },
"    linters = {
"      pylint = {
"        debounce = 100,
"        sourceName = "pylint",
"        command = "pylint",
"        args = {
"          "--output-format",
"          "text",
"          "--score",
"          "no",
"          "--msg-template",
"          "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'",
"          "%file",
"        },
"        formatPattern = {
"          "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
"          {
"              line = 1,
"              column = 2,
"              secuirty = 3,
"              message = 4
"          }
"        },
"        rootPatterns ={
"            ".vim",
"            ".git",
"            "pyproject.toml",
"            "setup.py"
"        },
"        securities = {
"          I = "hint",
"          R = "info",
"          C = "info",
"          W = "warning",
"          E = "error",
"          F = "error"
"        },
"        offset = 1,
"        formatLines = 1
"      },
"    },
"  }
"}
"EOF

nnoremap <leader>sv :source $MYVIMRC<CR>

" vim-compe
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.source = {
    \ 'path': v:true,
    \ 'buffer': v:true,
    \ 'nvim_lsp': v:true,
    \ }
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
