export LANG=ja_JP.UTF-8
alias open=cygstart
alias e="explorer"

export XDG_CONFIG_HOME=~/.config

# Windows Git Bashでtreeコマンド
alias tree='tree -N'

export PYTHONHOME=c/tools/msys64/mingw64

NODIST_BIN_DIR__=$(echo "$NODIST_PREFIX" | sed -e 's,\\,/,g')/bin; if [ -f "$NODIST_BIN_DIR__/nodist.sh" ]; then . "$NODIST_BIN_DIR__/nodist.sh"; fi; unset NODIST_BIN_DIR__;

# Git BashからGvimを呼び出す
alias gvim='/c/vim/vim81-kaoriya-win64/gvim.exe -c "set fenc=utf-8"'


