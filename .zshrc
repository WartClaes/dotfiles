# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
eval "$(starship init zsh)"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
