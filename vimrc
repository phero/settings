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
nnoremap zt zt10<C-y>
nnoremap n nzt10<C-y>
nnoremap N Nzt10<C-y>
nnoremap * *zt10<C-y>
nnoremap # #zt10<C-y>
nnoremap j gj
nnoremap k gk
vnoremap v $h
vnoremap * "zy:let @/ = @z<CR>n
nnoremap <C-I> <C-I>zz
nnoremap <C-O> <C-O>zz
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

noremap <C-P> :exec ":!time pypy3 %"<CR>
noremap <C-J> :exec ":!time python %"<CR>
noremap <Space>a :exec ":vimgrep! " . input("word? where? ")<CR>

autocmd FileType css setl autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType less setl autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType htmldjango set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType xml set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
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
NeoBundle 'tomtom/tcomment_vim'
NeoBundle "ctrlpvim/ctrlp.vim"

"--------------------------------------------------------------------------------------------------
"   unite.vimの設定
"   cf. http://qiita.com/jnchito/items/5141b3b01bced9f7f48f
"noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <C-@> :Unite file_mru<CR>
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
let g:flake8_show_in_file=1

"--------------------------------------------------------------------------------------------------
"   tcommentの設定
"--------------------------------------------------------------------------------------------------
let g:tcomment_opleader1 = 't'

"--------------------------------------------------------------------------------------------------
"   ctrlpvimの設定
"--------------------------------------------------------------------------------------------------
let g:ctrlp_map = '<C-N>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '.*coverage.*,virtualenv',
  \ }
nnoremap <C-N><C-N> :CtrlPMixed<CR>
nnoremap <C-N><C-L> :CtrlPLine<CR>
nnoremap <C-N><C-T> :CtrlPTag<CR>

call neobundle#end()

NeoBundleCheck
filetype plugin on

colorscheme hybrid
set background=dark

"--------------------------------------------------------------------------------------------------
"   Vimscript
"--------------------------------------------------------------------------------------------------

"--------------------------
"   全角数字を半角に変換
"--------------------------
function! HankakuNumberV() range
    python3 << END
import vim


def handle(text):
    for i in range(10):
        text = text.replace(chr(ord('０') + i), chr(ord('0') + i))
    return text

buf = vim.current.buffer
l1, c1 = buf.mark('<')
l2, c2 = buf.mark('>')
l1 -= 1
l2 -= 1

if l1 != l2:
    s1 = buf[l1].encode('utf-8')[c1:].decode('utf-8')
    for w2 in range(1, 5):
        try:
            s2 = buf[l2].encode('utf-8')[:c2 + w2].decode('utf-8')
        except UnicodeError:
            continue
        break
    s1 = handle(s1)
    s2 = handle(s2)
    buf[l1] = ''.join([buf[l1].encode('utf-8')[:c1].decode('utf-8'), s1])
    buf[l2] = ''.join([s2, buf[l2].encode('utf-8')[c2 + w2:].decode('utf-8')])
else:
    for w in range(1, 5):
        try:
            s = buf[l1].encode('utf-8')[c1:c2 + w].decode('utf-8')
        except UnicodeError:
            continue
        break
    s = handle(s)
    buf[l1] = ''.join([
        buf[l1].encode('utf-8')[:c1].decode('utf-8'),
        s,
        buf[l1].encode('utf-8')[c2 + w:].decode('utf-8'),
    ])

for l in range(l1 + 1, l2):
    buf[l] = handle(buf[l])
END
endfunction

function! HankakuNumberN()
    python3 << END
import vim
buf = vim.current.buffer
l, c = vim.current.window.cursor
l -= 1
line = buf[l]
for i in range(10):
    line = line.replace(chr(ord('０') + i), chr(ord('0') + i))
buf[l] = line
END
endfunction

vnoremap <Space>0 :call HankakuNumberV()<CR>
nnoremap <Space>0 :call HankakuNumberN()<CR>

"----------------------------
"   漢数字を半角数値に変換
"----------------------------
function! KanjiToNumberV() range
    python3 << END
import vim


def handle(text):
    text = text.replace('〇', '0')
    text = text.replace('一', '1')
    text = text.replace('二', '2')
    text = text.replace('三', '3')
    text = text.replace('四', '4')
    text = text.replace('五', '5')
    text = text.replace('六', '6')
    text = text.replace('七', '7')
    text = text.replace('八', '8')
    text = text.replace('九', '9')
    return text

buf = vim.current.buffer
l1, c1 = buf.mark('<')
l2, c2 = buf.mark('>')
l1 -= 1
l2 -= 1

if l1 != l2:
    s1 = buf[l1].encode('utf-8')[c1:].decode('utf-8')
    for w2 in range(1, 5):
        try:
            s2 = buf[l2].encode('utf-8')[:c2 + w2].decode('utf-8')
        except UnicodeError:
            continue
        break
    s1 = handle(s1)
    s2 = handle(s2)
    buf[l1] = ''.join([buf[l1].encode('utf-8')[:c1].decode('utf-8'), s1])
    buf[l2] = ''.join([s2, buf[l2].encode('utf-8')[c2 + w2:].decode('utf-8')])
else:
    for w in range(1, 5):
        try:
            s = buf[l1].encode('utf-8')[c1:c2 + w].decode('utf-8')
        except UnicodeError:
            continue
        break
    s = handle(s)
    buf[l1] = ''.join([
        buf[l1].encode('utf-8')[:c1].decode('utf-8'),
        s,
        buf[l1].encode('utf-8')[c2 + w:].decode('utf-8'),
    ])

for l in range(l1 + 1, l2):
    buf[l] = handle(buf[l])
END
endfunction

function! KanjiToNumberN()
    python3 << END
import vim
buf = vim.current.buffer
l, c = vim.current.window.cursor
l -= 1
line = buf[l]
line = line.replace('〇', '0')
line = line.replace('一', '1')
line = line.replace('二', '2')
line = line.replace('三', '3')
line = line.replace('四', '4')
line = line.replace('五', '5')
line = line.replace('六', '6')
line = line.replace('七', '7')
line = line.replace('八', '8')
line = line.replace('九', '9')
buf[l] = line
END
endfunction

vnoremap <Space>9 :call KanjiToNumberV()<CR>
nnoremap <Space>9 :call KanjiToNumberN()<CR>

"----------------------------------------------------------
"   Jinja2テンプレート用に選択範囲を{{ _('...') }}で括る
"----------------------------------------------------------
function! Jinja2MarkTranslationV() range
    python3 << END
import vim
buf = vim.current.buffer
l1, c1 = buf.mark('<')
l2, c2 = buf.mark('>')
l1 -= 1
l2 -= 1
for w2 in range(1, 5):
    try:
        buf[l2].encode('utf-8')[:c2 + w2].decode('utf-8')
    except UnicodeError:
        continue
    break
buf[l2] = "') }}".join([
    buf[l2].encode('utf-8')[:c2 + w2].decode('utf-8'),
    buf[l2].encode('utf-8')[c2 + w2:].decode('utf-8'),
])
buf[l1] = "{{ _('".join([
    buf[l1].encode('utf-8')[:c1].decode('utf-8'),
    buf[l1].encode('utf-8')[c1:].decode('utf-8'),
])
END
endfunction

function! Jinja2MarkTranslationN()
    python3 << END

import vim
buf = vim.current.buffer
l, c = vim.current.window.cursor
l -= 1
buf[l] = "{{{{ _('{}') }}}}".format(buf[l])
END
endfunction

vnoremap _ :call Jinja2MarkTranslationV()<CR>
nnoremap _ :call Jinja2MarkTranslationN()<CR>
