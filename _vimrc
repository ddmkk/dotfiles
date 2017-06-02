" vi互換の動作を無効にする（※.vimrcが存在する時点で無効と同義らしい）
if !&compatible
    set nocompatible
endif

" rm.exeパス指定
let $PATH = $PATH . ';C:\MinGW\bin;C:\MinGW\msys\1.0\bin;'

" ------------------------------------------------
" dein.vim
" ------------------------------------------------
" dein自体の自動インストール
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    execute "!git clone git@github.com:Shougo/dein.vim.git" s:dein_repo_dir
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

let s:toml = s:dein_dir . '/dein.toml'
let s:toml_lazy = s:dein_dir . '/dein_lazy.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:toml_lazy, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

" 未インストールのプラグインがある場合、自動インストール
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

filetype plugin indent on

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

"-------------------------------------
" ファイル保存時に無駄な空白を削除する
function! s:Rtrim()
    let s:cursor = getpos(".")
    if &filetype == "markdown"
        " .mdはブランク2個で改行なので削除せずアンダーラインを引く
        %s/\s\+\(\s\{2}\)$/\1/e
        match Underlined /\s\{2}/
    else
        %s/\s\+$//e
    endif
    call setpos(".", s:cursor)
endfunction

augroup FixWhiteSpace
    autocmd!
    " autocmd BufWritePre * :FixWhitespace
    " autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePre * :call s:Rtrim()
augroup END
" ------------------------------------

" .vimrcを一瞬で開く、反映させる
nnoremap <F5> :<C-u>edit $MYVIMRC<CR>
nnoremap <F6> :<C-u>edit $MYGVIMRC<CR>
nnoremap <F7> :<C-u>source $MYVIMRC<CR>
            \ :source $MYGVIMRC<CR>

" dein.tomlを一瞬で開く
nnoremap <F8> :<C-u>edit ~/.vim/dein/dein.toml<CR>
nnoremap <F9> :<C-u>edit ~/.vim/dein/dein_lazy.toml<CR>

" .vimrcを更新したら自動で反映させる
augroup AutoloadVimrc
    autocmd!
    autocmd BufWritePost *.vimrc source $MYVIMRC | set foldmethod=marker
    autocmd BufWritePost *.gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" ファイルの種類別インデント設定
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.scss setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.pug setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"--------------------------------------------
" 見た目 （最小限）
"--------------------------------------------
colorscheme desert
"シンタックスカラーリングを設定する
syntax on
"行番号を表示する
set number
"編集中のファイル名を表示する
set title
"入力中のコマンドを表示する
set showcmd

" ===========================================
" ▼プラグイン別設定
" ===========================================

"--------------------------------------------
" ★emmet-vim
"--------------------------------------------
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_settings = {
\   'variables': {
\       'lang': "ja"
\   }
\ }

"--------------------------------------------
" ★vim-indent-guides
"--------------------------------------------
" 自動カラー無効
let g:indent_guides_auto_colors=0
" vim 起動時 プラグインを自動起動"
let g:indent_guides_enable_on_vim_startup=1
" ガイドの幅
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=30

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#333333 ctermbg=black "奇数
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#222222 ctermbg=darkgray "偶数

" ------------------------------------------"
" ★Unite.vim
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
" grep 検索
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep 検索の再呼びだし
nnoremap <silent> ,r :<C-u>UniteResume search-buffer<CR>
" unite grepにag(The Silver Searcher)を使う
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

"---------------------------------------------
" ★VimFiler
"---------------------------------------------
let mapleader = "\<Space>"

" ▼カーソルの動きとバッティングするのでコメントアウト
" nnoremap <silent><C-f> :VimFiler<CR>

nnoremap <F2> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<Cr>
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
" ★Syntastic
"----------------------------------------------
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
let g:syntastic_mode_map = {'mode': 'passive',
                            \ 'active_filetypes': ['php', 'ruby', 'javascript', 'json'],
                            \ 'passive_filetypes': [] }
" javascript
let g:syntastic_javascript_checkers = ['eslint']

" php
" 主に動いているのはPHPCodeSniffer
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers = ['phpmd']
" 引数でtab-width=4を指定しないと検証エラーになるので回避するため設定
let g:syntastic_php_phpcs_args='--tab-width=4'
" なんでか分からないけど php コマンドのオプションを上書かないと動かなかった
" let g:syntastic_php_php_args = '-l'

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
" let g:splitjoin_split_mapping = ''
" let g:splitjoin_join_mapping = ''
" 1行を複数行に展開
" nmap <Leader>s :SplitjoinSplit<CR>
" 複数行を1行に格納
" nmap <Leader>j :SplitjoinJoin<CR>
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

" ECMAScript2015(ES6)のシンタックス設定
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile,BufReadPre *.pug setfiletype pug
autocmd BufRead,BufNewFile,BufReadPre *.md setfiletype markdown

