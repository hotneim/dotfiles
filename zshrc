#
#  ██╗  ██╗ ██████╗
#  ██║  ██║██╔═══██╗   Håkon Otneim
#  ███████║██║   ██║   haakon.otneim@protonmail.com
#  ██╔══██║██║   ██║   hotneim.github.com
#  ██║  ██║╚██████╔
#  ╚═╝  ╚═╝ ╚═════╝
#
# zshrc - configuration for the zsh

# File listings
alias ls="lsd -lL"
alias la="lsd -lA"

# Open config files
alias zs="nvim ~/.zshrc"

# Git shortcuts
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gh="git hist"       # (Requires git hist to be defined in .gitconfig)

# Locations
alias w="cd ~/work"
alias h="cd ~"
alias o="cd ~/Onedrive\ -\ Norges\ Handelshøyskole/"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Activate conda virtual environments
alias ds="conda activate ~/work/venv/ds"

# Notes
alias notes='cd ~/work/notes/' 
alias review='nvim ~/work/notes/inbox/*.md'

# Add folder of binaries to path
export PATH="$PATH:/Users/hakon/work/config/bin"

# Enable starship prompt
eval "$(starship init zsh)"
