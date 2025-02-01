set encoding=utf-8
scriptencoding utf-8

" vi の無効化
if &compatible
  set nocompatible
endif

" Vundle --------------------------------------------------------- set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim' " vundleに必要
    Plugin 'vim-jp/vimdoc-ja'
    Plugin 'preservim/nerdtree'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'godlygeek/tabular'
    Plugin 'preservim/vim-markdown'
    Plugin 'iamcco/markdown-preview.nvim'
    Plugin 'neoclide/coc.nvim', 'release'
    Plugin 'joshdick/onedark.vim'
    Plugin 'lervag/vimtex'
    Plugin 'Sirver/ultisnips'
    Plugin 'honza/vim-snippets'
call vundle#end()
filetype plugin indent on

" Package----------------------------------------------------------
packadd! matchit

" 基本形 -----------------------------------------------------------
set backspace=indent,eol,start
set history=200
set ruler
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set wrap
set list
set listchars=tab:▸-,trail:-,nbsp:⍽,eol:↲,extends:»,precedes:«
hi NonText ctermfg=59
hi SpecialKey ctermfg=59
syntax on
set belloff=all
set number
set helplang=ja,en
set virtualedit=block
set showmatch
set laststatus=2
set smarttab
set shiftwidth=4
filetype on

" 括弧飛び
set matchpairs=(:),{:},[:],<:>,":",':'
" inoremap xx <ESC>%%a<RIGHT>

" 補完 ---------------------------------------------------
inoremap jj <ESC>
nnoremap j gj
nnoremap k gk
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap {<space> {<space><space>}<LEFT><LEFT>
inoremap [<space> [<space><space>]<LEFT><LEFT>
inoremap (<space> (<space><space>)<LEFT><LEFT>
inoremap {<Enter> <CR>{}<Left><CR><ESC><UP>o
inoremap [<Enter> []<Left><CR><ESC><UP>o
inoremap (<Enter> ()<Left><CR><ESC><UP>o
inoremap /* /*<space><space>*/<LEFT><LEFT><LEFT>

" emacs風 ----------------------------------------------------
nnoremap <C-a> ^
nnoremap <C-e> $

" 検索 ----------------------------------------------------
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

" ターミナル ----------------------------------------------
set splitbelow
set termwinscroll=10000
set termwinsize=10x0

" 言語インデント -----------------------------------------
filetype plugin indent on
filetype plugin on

" テーマ --------------------------------------------------
syntax enable
colorscheme monokai

" markdownなんちゃか
let g:vim_markdown_folding_disabled = 1

" coc.nvim ------------------------------------------------
set statusline^=%{coc#status()}
set nobackup
set nowritebackup

set updatetime=300 " なにかのupdate time
set signcolumn=yes " 警告をだすか

" タブで選択
"inoremap <silent><expr> <TAB>
"      \ coc#pum#visible() ? coc#pum#next(1) :
"      \ CheckBackspace() ? "\<Tab>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" enterで確定, C-g uで確定解除
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" [g か ]g でdiagnosis bufferを開ける...らしい
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
" gdコード定義， gyコードタイプ定義, gi実装, grリファレンス
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" なんかドキュを表示
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" 仮
imap <C-l> <Plug>(coc-snippets-expand)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
if has('nvim')
  inoremap <silent><expr> <c-l> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" ultisnipps ---------------------------------------------------
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips',$HOME.'/.vim/bundle/vim-snippets/UltiSnips']
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<Nop>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"
let g:coc_snippet_next = '<C-n>'
let g:coc_snippet_prev = '<C-p>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" vimtex ---------------------------------------------------------------
filetype plugin on
filetype indent on
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
let g:vimtex_compiler_latexmk = {}

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-f',
    \ ],
    \}

