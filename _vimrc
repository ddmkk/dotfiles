"--------------------------------------------------
" プラグイン
"--------------------------------------------------
if 0 | endif

if &compatible
    set nocompatible
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shouge/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'violetyk/neocomplete-php.vim'
NeoBundle 'tpope/vim-fugitive',{'augroup':'fugitive'}
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'sjl/badwolf'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nathanaelkane/vim-indent-guides'
" シングルクオートとダブルクオートの入れ替えなど
NeoBundle 'tpope/vim-surround'
" コメント関連
NeoBundle 'tomtom/tcomment_vim'
" HTML5タグもシンタックス認定
NeoBundle 'othree/html5.vim'
" CSS3もシンタックス追加
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'jelera/vim-javascript-syntax'
" Emmet
NeoBundle 'mattn/emmet-vim'
NeoBundle 'AtsushiM/sass-compile.vim'
NeoBundle 'tyru/restart.vim'
NeoBundle 'vim-scripts/smarty-syntax'
NeoBundle 'beyondwords/vim-twig'
" 任意の2箇所のdiffを表示
NeoBundle 'AndrewRadev/linediff.vim'
" Gitの変更箇所をマーク
NeoBundle 'airblade/vim-gitgutter'
" 行末の余計な空白を削除
NeoBundle 'bronson/vim-trailing-whitespace'
" 検索を速く
NeoBundle 'rking/ag.vim'
" テキスト揃え
NeoBundle 'junegunn/vim-easy-align'
" NERDTree
" NeoBundle 'scrooloose/nerdtree'
" ファイル保存時にコードチェックを行う ESLint
NeoBundle 'scrooloose/syntastic'
" うまく動いていない
" NeoBundle 'pmsorhaindo/syntastic-local-eslint.vim'
" JSLint （ESLintを使うのでコメントアウト）
" NeoBundle 'basyura/jslint.vim'
" splitjoin.vim
NeoBundle 'AndrewRadev/splitjoin.vim'
" EJSもシンタックス追加
NeoBundle 'nikvdp/ejs-syntax'
" ECMAScript2015(ES6)でのシンタックス追加
NeoBundleLazy 'othree/yajs.vim', {'autoload':{'filetypes':['javascript']}}
" pug（旧jade）シンタックス追加"
NeoBundleLazy 'digitaltoad/vim-pug', {'autoload':{'filetypes':['pug']}}

call neobundle#end()

" Required:
" filetypeプラグインによる indentをonに設定
filetype plugin indent on

NeoBundleCheck

"}}}

" rm.exeパス指定
let $PATH = $PATH . ';C:\MinGW\bin;C:\MinGW\msys\1.0\bin'

"---------------------------------------------------------------
"基本
"---------------------------------------------------------------
"文字コードをUTF-8にする
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
"ファイル変更中でも他のファイルを開けるようにする
set hidden
"ファイル内容が変更されると自動読み込みする
set autoread
"バックアップディレクトリを指定する
set backupdir=$HOME/.vim/backup
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer
"スワップファイルディレクトリを指定する
set directory=$HOME/.vim/backup,c:\temp
"履歴保存数
set history=1000
set undodir=$HOME/.vim/undo
"インクリメンタルサーチを行う
set incsearch
"検索結果をハイライトする
set hlsearch
"検索時に文字の大小を区別しない
set ignorecase
"検索時に大文字を含んでいたら大小を区別する
set smartcase
"検索をファイルの先頭へループする
set wrapscan
set autoindent
"行頭での<Tab>の幅
set shiftwidth=4
"行頭以外での<Tab>の幅
set tabstop=4
"<Tab>の代わりに<Space>を挿入する
set expandtab
"expandtabで<Tab>が対応する<Space>の数
set softtabstop=4
set backspace=indent,eol,start
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"クリップボードを利用する
set clipboard=unnamed
"勝手に改行しないようにする
set tw=0
"勝手に改行しないようにする
set textwidth=0
"勝手に改行しないようにする
set formatoptions=q
"勝手に改行しないようにする
autocmd Filetype text setlocal textwidth=0
"タブ、行末等の不可視文字を表示する
set list
set listchars=tab:>\ ,trail:_,eol:$
set modifiable
set write
" ステータスラインを常に表示
set laststatus=2
" 編集中のファイルのディレクトリに自動的にカレントディレクトリを切り替える
set noautochdir
"カーソル行の背景色を変更
set cursorline
" 長すぎるシンタックスのカラーリングOFF
" set synmaxcol=200
" 折り返し時に表示単位での移動をできるようにする
nnoremap j gj
nnoremap k gk
"インサートモードからjjでノーマルモードに戻れるようにする
inoremap <silent> jj <ESC>
" 2回ESCを押したら検索のハイライトをやめる
nmap <Esc><Esc> :nohlsearch<CR><ESC>
" ハイライトを一時的に無効化するショートカット
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"Yを行末までのヤンクとする
nnoremap Y y$
"貼り付けたテキストの末尾へ自動的に移動する
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"貼りつけ時にペーストバッファが上書きされないようにする
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=brown
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" {{{
" ファイル保存時に無駄な空白を削除する
" }}}
augroup FixWhiteSpace
    autocmd!
    autocmd BufWritePre * :FixWhitespace
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" .vimrcを一瞬で開く、反映させる
nnoremap <F5> :<C-u>edit $MYVIMRC<CR>
nnoremap <F6> :<C-u>edit $MYGVIMRC<CR>
nnoremap <F7> :<C-u>source $MYVIMRC<CR>
            \ :source $MYGVIMRC<CR>

" .vimrcを更新したら自動で反映させる
augroup AutoloadVimrc
    autocmd!
    autocmd BufWritePost *.vimrc source $MYVIMRC | set foldmethod=marker
    autocmd BufWritePost *.gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" {{{
" ファイルの種類別設定
" }}}
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.scss setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"---------------------------------------------------------------
" ここからプラグイン
"---------------------------------------------------------------

" emmet-vim
let g:user_emmet_leader_key='<C-e>'

" vim-indent-guides
let g:indent_guides_auto_colors=0 "自動カラー無効
let g:indent_guides_enable_on_vim_startup=1 "vim 起動時 プラグインを自動起動
let g:indent_guides_guide_size=1 "ガイドの幅
let g:indent_guides_color_change_percent=30
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#333333 ctermbg=black "奇数
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#444444 ctermbg=darkgray "偶数

"restart.vim
" 終了時に保存するセッションオプションを設定する
" ==========================================
" let g:restart_sessionoptions
            " \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

" ------------------------------------------"
"  Unite.vim
" -----------------------------------------"
" 入力モードで開始
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_limit = 200
" file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
" let g:unite_source_history_yank_enable = 1

try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#filters#matcher_default#use(['mather_fuzzy'])
catch
endtry
" nnoremap <Space><Space> :split<CR> :<C-u>Unite -start-insert file_rec/async<CR>
" :nnoremap <Space>r <Plug>(unite_start)

let mapleader = "\<Space>"

nnoremap [unite] <Nop>
nmap <Leader>f [unite]

" unite.vim keymap
nnoremap [unite]u :<C-u>Unite -no-split<Space>
" nnoremap [unite]u :<C-u>Unite<Space>
nnoremap <silent> [unite]y :<C-u>Unite<Space>history/yank<CR>
"現在開いているファイルのディレクトリ下のファイル一覧
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir<Space>-buffer-name=files<Space>file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]u :<C-u>Unite<Space>file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite<Space>-buffer-name=register<Space>register<CR>

" Netrw
" set nocp

"---------------------------------------------
" VimFiler
"---------------------------------------------
let mapleader = "\<Space>"
" nnoremap <silent><C-f> :VimFiler<CR>
" nnoremap <F2> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<Cr>
" Vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
" 現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=40 -no-quit<CR>
"デフォルトのキーマッピングを変更
augroup vimrc
    autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
    nmap <buffer> q <Plug>(vimfiler_exit)
    nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction

"----------------------------------------------
" Syntastic設定
" オープン時にチェック
let g:syntastic_check_on_open = 1
" ファイル保存時にチェック
let g:syntastic_check_on_save = 1
" エラー行にサイン表示
let g:syntastic_enable_signs = 1
" location list を常に更新
let g:syntastic_always_populate_loc_list = 0
" location list を常に表示
let g:syntastic_auto_loc_list = 0
" :wq で終了するときもチェックする
let g:syntastic_check_on_wq = 0
" javascriptチェックにeslintを使用
let g:syntastic_javascript_checkers = ['eslint']

" PHP
" なんでか分からないけど php コマンドのオプションを上書かないと動かなかった
let g:syntastic_php_php_args = '-l'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"----------------------------------------------
" JsLint 設定
" function! s:javascript_filetype_settings()
"     autocmd BufLeave <buffer> call jslint#clear()
"     autocmd BufWritePost <buffer> call jslint#check()
"     autocmd CursorMoved <buffer> call jslint#message()
" endfunction
" autocmd FileType javascript call s:javascript_filetype_settings()

"----------------------------------------------
" jshint 設定
"jshint設定ファイルの場所を指定
" let g:syntastic_javascript_jshint_args = '--config "' . $HOME . '/.jshintrc'
" let g:syntastic_javascript_jshint_config = $HOME . '/.jshintrc'
" let g:syntastic_debug = 3

"-----------------------------------------------
" splitjoin.vim キーバインディング（Rubyメイン）
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
" 1行を複数行に展開
nmap <Leader>s :SplitjoinSplit<CR>
" 複数行を1行に格納
nmap <Leader>j :SplitjoinJoin<CR>

"-----------------------------------------------
" ejsファイルのシンタックス設定
autocmd BufNewFile,BufRead *.ejs set filetype=ejs
autocmd BufNewFile,BufRead *._ejs set filetype=ejs

function! s:DetectEjs()
    if getline(1) =~ '^#!.*\<ejs\>'
        set filetype=ejs
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectEjs()
"-----------------------------------------------
" ECMAScript2015(ES6)のシンタックス設定
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
"-----------------------------------------------
" pug(旧jade)のシンタックス設定
autocmd BufRead,BufNewFile,BufReadPre *.pug setfiletype pug

