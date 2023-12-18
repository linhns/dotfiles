set nocompatible
filetype off

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug '~/.fzf'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'vim-test/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'romainl/vim-cool' "Disable highlight search when done

" Syntactic
Plug 'sheerun/vim-polyglot'
Plug 'cespare/vim-toml', {'branch': 'main'}
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'NoahTheDuke/vim-just'
Plug 'neovimhaskell/haskell-vim'

" AI tools
Plug 'github/copilot.vim'
call plug#end()

filetype plugin indent on

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Leader
let mapleader = ","
let maplocalleader = "\\"

" Ack
let g:ackprg = 'rg --vimgrep --no-heading --hidden --smart-case'
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1
cnoreabbrev Ack Ack!
nnoremap <Leader>/ :Ack!<Space>

let test#strategy = "dispatch"

" Shorter update time
set updatetime=300

" Show signcolumn
set signcolumn=yes

" CoC settings
inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <C-Space> coc#refresh()
else
    inoremap <silent><expr> <C-@> coc#refresh()
endif

" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Theme
if (has('termguicolors'))
    set termguicolors
endif

set background=dark
" let g:seoul256_background=235
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection=0
let g:gruvbox_number_column='bg1'
let g:gruvbox_sign_column='bg0'
colorscheme gruvbox

" Cursor line
" set cursorline

" No backup
set nobackup
set nowritebackup

" Manages multiple buffers effectively
set hidden

" Switch buffer behavior
set switchbuf+=usetab,newtab

" Enable spellcheck
set spell spelllang=en_us

" Status line
set laststatus=2

" Turn off mode showing in status line
set noshowmode

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! LightlineObsession()
    return '%{ObsessionStatus()}'
endfunction

let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'obsession', 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ 'component_expand': {
            \   'obsession': 'LightlineObsession'
            \ },
            \ }

" GitGutter
let g:gitgutter_preview_win_floating = 1
nnoremap ]h <Plug>(GitGutterNextHunk)
nnoremap [h <Plug>(GitGutterPrevHunk)

" Tabline
set stal=2

" Wildmenu
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*/.git/*,*/.svn/*

" Backspace
set backspace=eol,start,indent

" Optional, configure as-you-type completions
set completeopt=menu,menuone,preview,noselect,noinsert

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=manual
set foldcolumn=2

"Turn on hybrid line numbers
set number
set relativenumber

set fo+=t

" Round indents
set shiftround

" Autowrite
set autowrite

" Show matching brackets
set sm mat=2

" Lazy redraw
set lazyredraw

" No sound on errors
set noerrorbells vb t_vb=[?5h$<20>[?5l

" Use utf-8 encoding
set encoding=utf8

" Set tab options
set expandtab ts=4 sw=4 sts=4 ai si wrap

" Line breaks
set tw=80 lbr
set colorcolumn=81

" Mouse support
set mouse=a

set notildeop

" Splits
set splitbelow
set splitright

" Persistent undo
set undofile
if !has('nvim')
    set undodir=~/.vim/undo
endif

augroup vimrc
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

function! AutoCenter()
    if (winline() >= (winheight(0) * 2 / 3))
        normal! zz
    endif
endfunction

" Auto center
augroup autocenter
    autocmd!
    autocmd InsertEnter * :call AutoCenter()
augroup end

" Tab switches
nnoremap <leader>p :tabp<CR>
nnoremap <leader>n :tabn<CR>
nnoremap <leader>t :term ++close<CR><C-w>:execute "resize " . (winheight(0) * 2/3)<CR>

" Use <leader><leader> to change buffers
nnoremap <leader><leader> :e #<CR>

nnoremap <leader>x :tabclose<CR>
nnoremap <leader>o :tabnew \| :FZF<CR>

" Traverse quickfix list
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Quickly open .vimrc
nnoremap <leader>ev :tabnew ~/dotfiles/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Shortcut to open FZF
nnoremap <silent> <leader><space> :FZF<CR>

" Smoother splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-W>W <C-W><C-P>
nnoremap <C-W><C-W> <C-W><C-P>
tnoremap <C-W>W <C-W><C-P>
tnoremap <C-W><C-W> <C-W><C-P>

" Stop using arrow keys
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>

inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

" Fast move to start/end of line
nnoremap H 0
nnoremap L $

" Show next match at center screen
nnoremap n nzz
nnoremap N Nzz

" Netrw
let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
" let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_localcopydircmd = 'cp -r'
hi! link netrwMarkFile Search

" Rust settings
autocmd BufNewFile,BufRead *.rs set filetype=rust

" Run `rustfmt` on save
let g:rustfmt_autosave = 1

augroup rust
    autocmd!
    autocmd FileType rust set colorcolumn=
augroup end

" Correct syntax highlighting for json
augroup filetype_json
    autocmd!
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup end

" HTML nowrap
autocmd BufNewFile,BufRead *.html setlocal nowrap

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup end

" Clang settings
let g:clang_format#detect_style_file = 1
augroup clang
    autocmd!
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
    autocmd FileType c,cpp,objc ClangFormatAutoEnable
augroup end

" Haskell settings
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 1

augroup haskell
    autocmd!
    autocmd FileType haskell setlocal tabstop=2 shiftwidth=2 expandtab
augroup end

" GitHub Copilot
imap <silent><script><expr> <Right> copilot#Accept("")
let g:copilot_no_tab_map = v:true
" highlight CopilotSuggestion guifg=#00ff00 ctermfg=#00ff00

augroup copilot
    autocmd!
    autocmd BufReadPre *
                \ let f=getfsize(expand("<afile>"))
                \ | if f > 1000000 || f == -2
                \ | let b:copilot_enabled = v:false
                \ | endif
augroup end

augroup auto_save_and_reload_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview
augroup end

augroup auto_trim_blanks
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup end
