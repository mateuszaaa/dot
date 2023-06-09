# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=/usr/bin/nvim
export PATH=$PATH:$HOME/config/bin
export PATH=$PATH:$HOME/.cargo/bin/
export PATH=$PATH:$HOME/nvim-linux64/bin/
source $HOME/config/profile
source $HOME/config/bookmarks
source $HOME/config/functions
source $HOME/config/zsh-config
alias x="ls -la"
alias connect="cp"
#if [ -e $HOME/zsh-config ]; then
#    source $HOME/zsh-config
#fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
gpgconf --launch gpg-agent
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null


