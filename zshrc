export PATH=$PATH:$HOME/config/bin
source $HOME/config/profile
source $HOME/config/bookmarks
source $HOME/config/functions
source $HOME/config/zsh-config
if [ -e $HOME/zsh-config ]; then
    source $HOME/zsh-config
fi
#autoload edit-command-line
#zle -N edit-command-line
#bindkey '^Xe' edit-command-line
