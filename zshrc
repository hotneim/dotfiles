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

## Activate conda virtual environments
#alias ds="conda activate ~/work/venv/ds"

# Use bat instead of cat (requires "brew install bat")
alias cat="bat"

# Notes
alias notes='cd ~/work/notes/' 
alias review='nvim ~/work/notes/inbox/*.md'

# Add folder of binaries to path
export PATH="$PATH:/Users/hakon/work/dotfiles/bin"

# Source zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable fuzzy matching in zsh completions
zstyle ':completion:*' matcher-list 'r:|?=**'
zstyle ':completion:*' accept-exact true
zstyle ':completion:*' list-suffixes true

# Initialize zsh completion system
autoload -U compinit && compinit

# Source fzf-tab
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

# Source fzf if it's not already added by the installation script
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Needed this for homebrew to function properly
export PATH=/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/hakon/work/config/bin:/opt/homebrew/bin:/opt/homebrew/bin -

# Enable starship prompt
eval "$(starship init zsh)"


