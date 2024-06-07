# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Soft links for all the configuration files
ln -s /Users/hakon/work/config/.gitconfig /Users/hakon/.gitconfig
ln -s /Users/hakon/work/config/.zprofile /Users/hakon/.zprofile
ln -s /Users/hakon/work/config/zshrc /Users/hakon/.zshrc
ln -s /Users/hakon/work/config/alacritty /Users/hakon/.config/alacritty
ln -s /Users/hakon/work/config/nvim /Users/hakon/.config/nvim
ln -s /Users/hakon/work/config/starship.toml /Users/hakon/.config/starship.toml
ln -s /Users/hakon/work/config/tmux.conf /Users/hakon/.tmux.conf
ln -s /Users/hakon/work/config/lsd.yaml /Users/hakon/.config/lsd/config.yaml

# Repositories needed for fuzzy tab completion in zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
