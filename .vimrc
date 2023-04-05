let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug '~/.fzf'
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

filetype plugin indent on

" Theme
set t_Co=256   

set background=dark
colorscheme PaperColor

" Status line
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Optional, configure as-you-type completions
set completeopt=menu,menuone,preview,noselect,noinsert

" Traverse quickfix list
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

"Turn on hybrid line numbers
set number
set relativenumber

" Make space more useful
nnoremap <leader><space> za

" 80 characters per line
set textwidth=80
set fo+=t
set colorcolumn=81
highlight ColorColumn ctermbg=darkgrey guibg=#592929

" Round indents
set shiftround

" Autowrite
set autowrite

" Set tab options
set tabstop=4
set shiftwidth=4
set expandtab

" Move line up and down
nnoremap - ddp
nnoremap <leader>- ddkP

inoremap <c-u> <esc>viwU
nnoremap <c-u> viwU

" Leader
let mapleader = ","

" Quickly open .vimrc
nnoremap <leader>ev :vsplit ~/dotfiles/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Shortcut to open FZF
nnoremap <silent> <leader><space> :FZF<CR>

" Smoother splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

autocmd BufNewFile,BufRead *.rs set filetype=rust

augroup rust_settings
    autocmd!
    autocmd FileType rust set colorcolumn=
augroup END
