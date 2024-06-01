
eval "$(/usr/local/bin/brew shellenv)"

# Code to ensure that the conda is not messed up by tmux

PATH=""
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi
