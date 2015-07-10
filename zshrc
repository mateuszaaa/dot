source /etc/profile
ROOT_DIR=~/.matconf
export PATH=$PATH:$ROOT_DIR/bin

######## OH MY ZSH ############
export ZSH=$ROOT_DIR/oh-my-zsh
ZSH_THEME="own"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git) 

source $ZSH/oh-my-zsh.sh
source $ROOT_DIR/bookmarks
source $ROOT_DIR/functions

