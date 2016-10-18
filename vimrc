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
set fileencodings=utf-8
nnoremap <C-H> :%y<CR>

let fftable={'dos': 'CRLF', 'unix': 'LF', 'mac': 'CR'}
set statusline=%f%m%r%h%w\%=type=%Y\|fenc=%{&fileencoding}\|enc=%{&encoding}\|%{fftable[&ff]}\|%l/%L-%v
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
vnoremap * "zy:let @/ = @z<CR>n
set clipboard+=unnamed
set clipboard+=unnamedplus

set indentkeys+=0#

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set wildmode=list:longest,full
set colorcolumn=100
set cursorline

autocmd FileType python setl autoindent smartindent commentstring=#%s cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
"autocmd FileType python let g:pydiction_location = ~/.vim/pydiction/complete-dict

autocmd FileType cs setl smartindent cinwords=if,else,for,while,try,except,catch,class
autocmd FileType cs setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd FileType markdown setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

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

function! s:ExecRuby()
    if g:ostype == 'Windows'
        let src = tempname()
        let dst = "Ruby Output"
        silent execute ":w " . src
        silent execute ":pedit! " . dst
        wincmd P
        setlocal buftype=nofile
        setlocal noswapfile
        setlocal syntax=none
        setlocal bufhidden=delete
        silent execute ":%! ruby " . src . " 2>&1"
        silent execute ":!rm " . src
        echo src
        wincmd p
    else
        exe "!time ruby %"
    endif
:endfunction
command! ExecRuby call <SID>ExecRuby()
map <silent> <C-B> :call <SID>ExecRuby()<CR>

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

autocmd QuickFixCmdPost *grep* cwindow
noremap <Space>g :exec ":vimgrep! /" . input("word? ") . "/ `git ls-files`"<CR>
noremap <Space>w :vimgrep! <cword> `git ls-files`<CR>
noremap <Space>a :exec ":vimgrep! " . input("word? where? ")<CR>

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
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'nvie/vim-flake8', {'autoload': {'filetypes': ['python']}}

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

"--------------------------------------------------------------------------------------------------
"   gist-vimの設定
"--------------------------------------------------------------------------------------------------
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
let g:gist_post_private = 1

"--------------------------------------------------------------------------------------------------
"   vim-flake8の設定
"--------------------------------------------------------------------------------------------------
noremap <C-K> :call Flake8()<CR>

call neobundle#end()

NeoBundleCheck
filetype plugin on

colorscheme hybrid
set background=dark

"--------------------------------------------------------------------------------------------------
"   Vimscript
"--------------------------------------------------------------------------------------------------

function! HankakuNumber() range
    python << END
# coding=utf-8
import vim
buf = vim.current.buffer
lineid1, col1 = buf.mark('<') or vim.current.window.cursor
lineid2, col2 = buf.mark('>') or vim.current.window.cursor
lineid1 -= 1
lineid2 -= 1
current_lineid, current_col = vim.current.window.cursor
current_lineid -= 1
if (current_lineid, current_col) != (lineid1, col1):
    lineid1 = lineid2 = current_lineid

for lineid in xrange(lineid1, lineid2 + 1):
    line = buf[lineid]
    u = line.decode('utf-8')
    for i in xrange(10):
        u = u.replace(unichr(ord(u'０') + i), unichr(ord(u'0') + i))
    buf[lineid] = u
END
endfunction
vnoremap <Space>0 :call HankakuNumber()<CR>
nnoremap <Space>0 :call HankakuNumber()<CR>

function! KanjiToNumber() range
    python << END
# coding=utf-8
import vim
buf = vim.current.buffer
lineid1, col1 = buf.mark('<') or vim.current.window.cursor
lineid2, col2 = buf.mark('>') or vim.current.window.cursor
lineid1 -= 1
lineid2 -= 1
current_lineid, current_col = vim.current.window.cursor
current_lineid -= 1
if (current_lineid, current_col) != (lineid1, col1):
    lineid1 = lineid2 = current_lineid

for lineid in xrange(lineid1, lineid2 + 1):
    line = buf[lineid]
    u = line.decode('utf-8')
    u = u.replace(u'〇', u'0')
    u = u.replace(u'一', u'1')
    u = u.replace(u'二', u'2')
    u = u.replace(u'三', u'3')
    u = u.replace(u'四', u'4')
    u = u.replace(u'五', u'5')
    u = u.replace(u'六', u'6')
    u = u.replace(u'七', u'7')
    u = u.replace(u'八', u'8')
    u = u.replace(u'九', u'9')
    buf[lineid] = u
END
endfunction
vnoremap <Space>9 :call KanjiToNumber()<CR>
nnoremap <Space>9 :call KanjiToNumber()<CR>
