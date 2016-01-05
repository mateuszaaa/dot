export PATH=$PATH:$HOME/config/bin
source $HOME/config/profile
source $HOME/config/bookmarks
source $HOME/config/functions
source $HOME/config/.bash-config
if [ -e $HOME/.bash-config ]; then
    source $HOME/.bash-config
fi
