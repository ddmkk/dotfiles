" vi互換の動作を無効にする（※.vimrcが存在する時点で無効と同義らしい）
if !&compatible
    set nocompatible
endif

" rm.exeパス指定
" let $PATH = $PATH . ';C:\MinGW\bin;C:\MinGW\msys\1.0\bin;'
let $PATH = $PATH . ';C:\tools\msys64\usr\bin;'

" set runtimepath+=~/.vim
" set runtimepath+=C:\vim\vim81-kaoriya-win64

" プラグイン保存path
set packpath+=~/.vim

" Python
let g:python3_host_prog = 'C:\Python39\python.exe'
let g:python_host_prog = 'C:\Python27\python.exe'

" deinの読み込み前に指定
let mapleader = "\<Space>"

" ==============================================================
" dein.vim
" ==============================================================
" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" " Required:
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    " defxに必要
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    let s:toml = '~/.cache/dein/dein.toml'
    let s:toml_lazy = '~/.cache/dein/dein_lazy.toml'
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:toml_lazy, {'lazy': 1})

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

" アンインストール用
call map(dein#check_clean(), "delete(v:val, 'rf')")

" =============================================================

filetype off
" filetype plugin indent off
" filetype plugin indent on

"---------------------------------------------------------------
"基本
"---------------------------------------------------------------
"文字コードをUTF-8にする
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
" 自動判別機能追加
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
" 改行コードの自動認識
set fileformats=unix,dos,mac
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
set smartindent
"行頭での<Tab>の幅
set shiftwidth=4
"行頭以外での<Tab>の幅
set tabstop=4
"<Tab>の代わりに<Space>を挿入する
set expandtab
"expandtabで<Tab>が対応する<Space>の数
"キーボードでTabキーを押したときに挿入される空白の量。0の場合はtabstopの値を引き継ぐ
set softtabstop=0
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
set synmaxcol=400
" 折り返し時に表示単位での移動をできるようにする
nnoremap j gj
nnoremap k gk
"インサートモードからjjでノーマルモードに戻れるようにする
inoremap <silent> jj <ESC>
" 2回ESCを押したら検索のハイライトをやめる
nmap <Esc><Esc> :nohlsearch<CR><ESC>
" 自動的に日本語入力モードを解除する
inoremap <ESC><ESC> :set iminsert=0<CR>
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
nnoremap <F8> :<C-u>edit ~/.cache/dein/dein.toml<CR>
nnoremap <F9> :<C-u>edit ~/.cache/dein/dein_lazy.toml<CR>

" .vimrcを更新したら自動で反映させる
" augroup AutoloadVimrc
"     autocmd!
"     autocmd BufWritePost *.vimrc source $MYVIMRC | set foldmethod=marker
"     autocmd BufWritePost *.gvimrc if has('gui_running') source $MYGVIMRC
" augroup END

" ファイルの種類別インデント設定
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.scss setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.pug setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" -------------------------------------------------
" 辞書ファイルの登録
" -------------------------------------------------
" PHPとWordPress
autocmd FileType php :set dictionary=~/.vim/dict/php.dict,~/.vim/dict/vim-dict-wordpress/functions.dict,~/.vim/dict/vim-dict-wordpress/action-hooks.dict,~/.vim/dict/vim-dict-wordpress/filter-hooks.dict

"--------------------------------------------
" 見た目 （最小限）
"--------------------------------------------
" colorscheme hybrid
"シンタックスカラーリングを設定する
syntax on
"行番号を表示する
set number
"編集中のファイル名を表示する
set title
"入力中のコマンドを表示する
set showcmd
" ビープ音を可視化
set visualbell
" カッコ入力時の対応するカッコを表示
set showmatch

" ===========================================
" ▼プラグイン別設定
" ===========================================

" -------------------------------------------
" ★JSXシンタックス
" let g:vim_jsx_pretty_colorful_config = 1

"--------------------------------------------
" ★vim-json
" -------------------------------------------
" クオテーションを省略しないようにする
" set conceallevel=0
" let g:vim_json_syntax_conceal=0

"--------------------------------------------
" ★vim-indent-guides
"--------------------------------------------
" " vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
" let g:indent_guides_enable_on_vim_startup=1
" " ガイドをスタートするインデントの量
" let g:indent_guides_start_level=1
" " 自動カラーを無効にする
" let g:indent_guides_auto_colors=0
" " 奇数インデントのカラー
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
" " 偶数インデントのカラー
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
" " ハイライト色の変化の幅
" let g:indent_guides_color_change_percent = 30
" " ガイドの幅
" let g:indent_guides_guide_size = 1

" ------------------------------------------"
" ★Unite.vim
" -----------------------------------------"
" 入力モードで開始
" let g:unite_enable_start_insert = 1
" let g:unite_source_file_mru_limit = 200
" " file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
" let g:unite_source_file_mru_filename_format = ''
" " let g:unite_source_history_yank_enable = 1
" try
"     let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
"     call unite#filters#matcher_default#use(['mather_fuzzy'])
" catch
" endtry
" " nnoremap <Space><Space> :split<CR> :<C-u>Unite -start-insert file_rec/async<CR>
" " :nnoremap <Space>r <Plug>(unite_start)
" let mapleader = "\<Space>"
" nnoremap [unite] <Nop>
" nmap <Leader>f [unite]
" " unite.vim keymap
" nnoremap [unite]u :<C-u>Unite -no-split<Space>
" " nnoremap [unite]u :<C-u>Unite<Space>
" nnoremap <silent> [unite]y :<C-u>Unite<Space>history/yank<CR>
" "現在開いているファイルのディレクトリ下のファイル一覧
" nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir<Space>-buffer-name=files<Space>file<CR>
" "バッファ一覧
" nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
" "最近使用したファイル一覧
" nnoremap <silent> [unite]u :<C-u>Unite<Space>file_mru<CR>
" "ブックマーク一覧
" nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
" "レジスタ一覧
" nnoremap <silent> [unite]r :<C-u>Unite<Space>-buffer-name=register<Space>register<CR>
" " grep 検索
" nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" " カーソル位置の単語をgrep検索
" nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" " grep 検索の再呼びだし
" nnoremap <silent> ,r :<C-u>UniteResume search-buffer<CR>
" " unite grepにag(The Silver Searcher)を使う
" if executable('ag')
"     let g:unite_source_grep_command = 'ag'
"     let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"     let g:unite_source_grep_recursive_opt = ''
" endif

"---------------------------------------------
" ★VimFiler
"---------------------------------------------
" let mapleader = "\<Space>"

" ▼カーソルの動きとバッティングするのでコメントアウト
" nnoremap <silent><C-f> :VimFiler<CR>

" nnoremap <F2> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<Cr>
" Vimデフォルトのエクスプローラをvimfilerで置き換える
" let g:vimfiler_as_default_explorer = 1
"セーフモードを無効
" let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
" nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
" 現在開いているバッファをIDE風に開く
" nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=40 -no-quit<CR>
"デフォルトのキーマッピングを変更
" augroup vimrc
"     autocmd FileType vimfiler call s:vimfiler_my_settings()
" augroup END
" function! s:vimfiler_my_settings()
"     nmap <buffer> q <Plug>(vimfiler_exit)
"     nmap <buffer> Q <Plug>(vimfiler_hide)
" endfunction

" 作者のページから使用
" let g:vimfiler_tree_leaf_icon = "｜"
" let g:vimfiler_tree_opened_icon = "▼"
" let g:vimfiler_tree_closed_icon = "▷"
" let g:vimfiler_readonly_file_icon = "🔒"

" Use trashbox.
" Windows only and require latest vimproc.
"let g:unite_kind_file_use_trashbox = 1

"----------------------------------------------
" ★Syntastic
" ※ 非同期プラグイン"w0rp/ale"に変更。
"----------------------------------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" オープン時にチェック
" let g:syntastic_check_on_open = 1
" ファイル保存時にチェック
" let g:syntastic_check_on_save = 1
" エラー行にサイン表示
" let g:syntastic_enable_signs = 1
" location list を常に更新
" let g:syntastic_always_populate_loc_list = 0
" location list を常に表示
" let g:syntastic_auto_loc_list = 0
" :wq で終了するときもチェックする
" let g:syntastic_check_on_wq = 0
" let g:syntastic_mode_map = {'mode': 'passive',
"                             \ 'active_filetypes': ['php', 'ruby', 'javascript'],
"                             \ 'passive_filetypes': [] }
" javascript
" let g:syntastic_javascript_checkers = ['eslint']

" php
" 主に動いているのはPHPCodeSniffer
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
" let g:syntastic_php_checkers = ['phpmd']
" 引数でtab-width=4を指定しないと検証エラーになるので回避するため設定
" let g:syntastic_php_phpcs_args='--tab-width=4'
" なんでか分からないけど php コマンドのオプションを上書かないと動かなかった
" let g:syntastic_php_php_args = '-l'
"
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
" autocmd BufNewFile,BufRead *.ejs set filetype=ejs
" autocmd BufNewFile,BufRead *._ejs set filetype=ejs
"
" function! s:DetectEjs()
"     if getline(1) =~ '^#!.*\<ejs\>'
"         set filetype=ejs
"     endif
" endfunction
" autocmd BufNewFile,BufRead * call s:DetectEjs()

" ECMAScript2015(ES6)のシンタックス設定
" autocmd BufRead,BufNewFile *.es6 setfiletype javascript
" autocmd BufRead,BufNewFile,BufReadPre *.pug setfiletype pug
" autocmd BufRead,BufNewFile,BufReadPre *.md setfiletype markdown
" " eslint
" autocmd BufRead,BufNewFile *.eslintrc setfiletype javascript
" " vue
" autocmd BufRead,BufNewFile *.vue setfiletype vue
" " autocmd FileType vue syntax sync fromstart
" " PCSS(Postcss)
" autocmd BufRead,BufNewFile *.pcss setfiletype css
" " toml ※遅延読込テスト
" autocmd BufNewFile,BufRead *.toml set filetype=toml
" function! s:config_toml()
"     packadd vim-toml
" endfunction
" augroup lazyLoad
"     autocmd!
"     autocmd FileType toml call s:config_toml()
" augroup END

" ------------------------------------------------
" ★Markdown Preview
" ------------------------------------------------
" autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
" let g:previm_open_cmd = ''
" nnoremap [previm] <Nop>
" nmap <Space>p [previm]
" nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
" nnoremap <silent> [previm]r :call previm#refresh()<CR>et g:previm_open_cmd = 'open -a chrome'
" let g:vim_markdown_folding_disabled=1
" let g:previm_enable_realtime=1

" ------------------------------------------------
" ★open-browser.vim
" ------------------------------------------------
" let g:netrw_nogx = 1 " disable netrw's gx mapping.
" nmap gx <Plug>(openbrowser-smart-search)
" vmap gx <Plug>(openbrowser-smart-search)

" ------------------------------------------------
" ★VimShell
" ------------------------------------------------
" let mapleader = "\<Space>"
" nnoremap <silent> <Leader>is :VimShell<CR>
" nnoremap <silent> <Leader>ipy :VimShellInteractive python<CR>
" nnoremap <silent> <Leader>irb :VimShellInteractive irb<CR>
" vmap <silent> <Leader>ss :VimShellSendString<CR>
" nnoremap <silent> <Leader>ss :VimShellSendString<CR>
" nnoremap <silent> <Leader>ip :VimShellPop<CR>

" =================================================
" vim-airline
" =================================================

" Powerline系フォントを利用する
" set laststatus=2
" let g:airline_powerline_fonts = 1
" " タブを有効化する
" let g:airline#extensions#tabline#enabled = 1
" " タブに番号を表示する
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" " タブの切替キーバインド
" nmap <C-left> <Plug>AirlineSelectPrevTab
" nmap <C-right> <Plug>AirlineSelectNextTab
"
" let g:airline#extensions#whitespace#mixed_indent_algo = 1
" let g:airline_theme = 'term'
"
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
"
" " unicode symbols
" " タブの区切り文字を指定する
" " let g:airline_left_sep = '▶'
" " let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" " let g:airline_symbols.linenr = '␊'
" " let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = '☰'
" " let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" " let g:airline_symbols.paste = 'Þ'
" " let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'
"
" " powerline symbols
" " let g:airline_left_sep = ''
" " let g:airline_left_alt_sep = ''
" " let g:airline_right_sep = ''
" " let g:airline_right_alt_sep = ''
" " let g:airline_symbols.branch = ''
" " let g:airline_symbols.readonly = ''
" " let g:airline_symbols.linenr = ''
"
" " old vim-powerline symbols
" " let g:airline_left_sep = '⮀'
" " let g:airline_left_alt_sep = '⮁'
" " let g:airline_right_sep = '⮂'
" " let g:airline_right_alt_sep = '⮃'
" " let g:airline_symbols.branch = '⭠'
" " let g:airline_symbols.readonly = '⭤'
" " let g:airline_symbols.linenr = '⭡'

" ------------------------------------
" ★Surround.vim
" ------------------------------------
" ビジュアルモードで選択後、"S-"入力で選択範囲をpタグで囲む
" let g:surround_{char2nr("-")} = "<p>\r</p>"

"" 補完系（せっかくデフォであるのでいれておく）
" オムニ補完の設定（insertモードでCtrl+oで候補を出す、Ctrl+n Ctrl+pで選択、Ctrl+yで確定）
" set omnifunc=pythoncomplete#Complete
" set omnifunc=javascriptcomplete#CompleteJS
" set omnifunc=htmlcomplete#CompleteTags
" set omnifunc=csscomplete#CompleteCSS
" set omnifunc=xmlcomplete#CompleteTags
" set omnifunc=phpcomplete#CompletePHP

" -------------------------------------
" ★neocomplete.vim
" -------------------------------------
" " Disable AutoComplPop.
" let g:acp_enableAtStartup = 1
" " 起動時に有効化
" let g:neocomplete#enable_at_startup = 1
" " Use SmartCase
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 2
" let g:neocomplete#auto_completion_start_length = 2
" let g:neocomplete#skip_auto_completion_time = ''
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions',
"     \ 'php' : $HOME.'/.vim/dict/php.dict',
"     \ 'js' : $HOME.'/.vim/dict/js.dict',
"     \ 'ruby' : $HOME.'/.vim/dict/ruby.dict'
"     \ }
" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"   let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" let g:neocomplete#keyword_patterns['perl'] = '\h\w*->\h\w*\|\h\w*::\w*'
" let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"

" -------------------------------------
" ★deoplete.vim
" XXX 動かなかった…
" -------------------------------------
" let g:python3_host_prog='C:\Python37/python.exe'
" let g:deoplete#enable_at_startup=1
" let g:deoplete#auto_complete_delay=0
" let g:deoplete#auto_complete_start_length=1
" function! s:deoplete_enabled()
"     packadd deoplete.nvim
"     let g:python3_host_prog='C:\Python37/python.exe'
"     let g:deoplete#enable_at_startup=1
" endfunction
" augroup lazyLoad
"     autocmd!
"     autocmd InsertEnter call s:deoplete_enabled()
" augroup END

" -------------------------------------
" ale 非同期Lint
" -------------------------------------
" 保存時のみ実行
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" let g:ale_linters = { 'javascript': ['eslint'] }
" 表示に関する設定
" let g:ale_sign_error = '×'
" let g:ale_sign_warning = '⚡'
" let g:ale_echo_msg_format = '[%linter%]%code: %%s'
" let g:airline#extensions#ale#open_lnum_symbol = '('
" let g:airline#extensions#ale#close_lnum_symbol = ')'
" highlight link ALEErrorSign Tag
" highlight link ALEWarningSign StorageClass
" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
" -------------------------------------

" filetype plugin indent off

" -------------------------------------
" vim-go
" -------------------------------------
" let g:go_version_warning=0
"

" ダブルクォーテーションなどを整形する機能をオフに
let g:vim_markdown_conceal = 0
