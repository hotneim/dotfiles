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
alias o="cd /Users/hakon/OneDrive\ -\ Norwegian\ School\ of\ Economics"
alias ic="cd /Users/hakon/Library/Mobile\ Documents/com~apple~CloudDocs"

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
export PATH="$PATH:/Users/hakon/work/config/bin"
export PATH="/Library/TeX/texbin:$PATH"

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
# export PATH=/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/hakon/work/config/bin:/opt/homebrew/bin:/opt/homebrew/bin -

export PATH="/Library/TeX/texbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/hakon/work/config/bin:/opt/homebrew/bin"

# Use vi mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_custom_status) $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
# Enable starship prompt
eval "$(starship init zsh)"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

