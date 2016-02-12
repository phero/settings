if has('win32')
    let g:ostype = "Windows"
elseif has('mac')
    let g:ostype = "Mac"
else
    let g:ostype = system("uname")
endif

syntax on
filetype plugin indent off

set clipboard=autoselect
set encoding=utf-8
nnoremap <C-H> :%y<CR>

let fftable={'dos': 'CRLF', 'unix': 'LF', 'mac': 'CR'}
set statusline=%F%m%r%h%w\%=[type=%Y]\[fenc=%{&fileencoding}]\[enc=%{&encoding}]\[%{fftable[&ff]}]\[L.%l/%L]\[C.%v]
set laststatus=2

set t_Co=256
set lazyredraw
set ttyfast

set hls ic
set list
set listchars=tab:>.,trail:=,eol:\ ,extends:>,precedes:<,nbsp:%

set smartindent
set number
set is
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
nmap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap j gj
nnoremap k gk
vnoremap v $h
nnoremap <Tab> %
vnoremap <Tab> %
set clipboard+=unnamed
set clipboard+=unnamedplus

set indentkeys+=0#

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set wildmode=list:longest,full
set colorcolumn=100

autocmd FileType python setl autoindent smartindent commentstring=#%s cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
"autocmd FileType python let g:pydiction_location = ~/.vim/pydiction/complete-dict

autocmd FileType cs setl smartindent cinwords=if,else,for,while,try,except,catch,class
autocmd FileType cs setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

function! s:ExecPython()
    if g:ostype == 'Windows'
        let src = tempname()
        let dst = "Python Output"
        silent execute ":w " . src
        silent execute ":pedit! " . dst
        wincmd P
        setlocal buftype=nofile
        setlocal noswapfile
        setlocal syntax=none
        setlocal bufhidden=delete
        silent execute ":%! python " . src . " 2>&1"
        silent execute ":!rm " . src
        echo src
        wincmd p
    else
        exe "!time python %"
    endif
:endfunction
command! ExecPython call <SID>ExecPython()
map <silent> <C-J> :call <SID>ExecPython()<CR>

function! s:ExecPyPy()
    if g:ostype == 'Windows'
        let src = tempname()
        let dst = "PyPy Output"
        silent execute ":w " . src
        silent execute ":pedit! " . dst
        wincmd P
        setlocal buftype=nofile
        setlocal noswapfile
        setlocal syntax=none
        setlocal bufhidden=delete
        silent execute ":%! pypy " . src . " 2>&1"
        silent execute ":!rm " . src
        echo src
        wincmd p
    else
        exe "!time pypy %"
    endif
:endfunction
command! ExecPyPy call <SID>ExecPyPy()
map <silent> <C-P> :call <SID>ExecPyPy()<CR>

autocmd FileType haskell setl autoindent
autocmd FileType haskell setl smartindent cinwords=where
autocmd FileType haskell setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd FileType cpp setl smartindent cinwords=)
autocmd FileType cpp setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType cpp setl colorcolumn=80

autocmd FileType java setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType java setl smartindent autoindent

autocmd FileType css setl autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType htmldjango set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType xml set autoindent tabstop=4
autocmd FileType javascript set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType sh set autoindent tabstop=4 shiftwidth=4 softtabstop=4

function! ZenkakuSpace()
highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

"--------------------------------------------------------------------------------------------------
"   NeoBundle

"Requires:
"   mkdir -p ~/.vim/bundle/
"   git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'phero/vim-hybrid'

"--------------------------------------------------------------------------------------------------
"   unite.vimの設定
"   cf. http://qiita.com/jnchito/items/5141b3b01bced9f7f48f
noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <C-L> :Unite file_mru<CR>
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-H> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-H> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-V> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-V> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"--------------------------------------------------------------------------------------------------

"--------------------------------------------------------------------------------------------------
"   indentLineの設定
let g:indentLine_color_term = 236
"--------------------------------------------------------------------------------------------------

call neobundle#end()

NeoBundleCheck
filetype plugin on

colorscheme hybrid
set background=dark
