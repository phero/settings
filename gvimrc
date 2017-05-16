colorscheme hybrid
set background=dark

set columns=105
set laststatus=2
set lines=100
set noundofile
set ruler
set showcmd

"set guioptions-=m  "メニュー非表示
set guioptions-=T  "ツールバー非表示
set guioptions-=r  "垂直スクロールバー非表示
set guioptions-=R  "垂直スクロールバー非表示
set guioptions-=l  "垂直スクロールバー非表示
set guioptions-=L  "垂直スクロールバー非表示
set guioptions-=b  "水平スクロールバー非表示

autocmd FileType text setlocal textwidth=0

if has('win32')
    au GUIEnter * simalt ~x
    set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
    set guifont=Ricty_Diminished:h18:cSHIFTJIS
    set directory=C:/tmp/
    set backupdir=C:/tmp/
    set mouse=
    set visualbell t_vb=
    inoremap <silent> <ESC> <ESC>
    cd C:/Users/yasuhiro/Downloads/
else
    set guifont=Ubuntu\ Mono\ 12
endif
