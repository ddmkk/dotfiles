alias ls='ls --color=auto --show-control-chars'
alias phpunit="/cygdrive/c/xampp/php/phpunit c:/xampp/php/phpunit"
alias e="explorer"
alias python='winpty /c/Python27/python.exe'

export LANG=ja.UTF-8

if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

# expressコマンドへのパスを通す
export PATH=/c/Users/kigane/npm:$PATH

NODIST_BIN_DIR__=$(echo "$NODIST_PREFIX" | sed -e 's,\\,/,g')/bin; if [ -f "$NODIST_BIN_DIR__/nodist.sh" ]; then . "$NODIST_BIN_DIR__/nodist.sh"; fi; unset NODIST_BIN_DIR__;

# Go Lang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
