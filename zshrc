# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

function nnn {
  bash -xc "$@"; 
  if [ $? -eq 0 ]; then
    notify-send 'Success' "dir: $(pwd)\ncmd: $@" --icon=dialog-information --expire-time `bc <<< 1000*60*24` 
  else
    notify-send 'Failure' "dir: $(pwd)\ncmd: $@" --icon=dialog-information --expire-time `bc <<< 1000*60*24` 
  fi
}
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

function start_runner {
    ssh root@$1 su - github -c "/bin/bash -c 'screen -S runner -dm bash -c \"cd /home/github/actions-runner; TOKEN=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 OWNER=mangata-finance REPO=mangata-node ./start.sh\"'"
}
