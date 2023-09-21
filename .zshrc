source ~/.zsh-aliases

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "famiclone/zsh-lambda-theme"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/vim"

#OktaAWSCLI
if [[ -f "$HOME/.okta/bash_functions" ]]; then
    . "$HOME/.okta/bash_functions"
fi
if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then
    PATH="$HOME/.okta/bin:$PATH"
fi

# bun completions
[ -s "/Users/dentynok/.bun/_bun" ] && source "/Users/dentynok/.bun/_bun"

#fzf directory and cd
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
quick_cd() {
  #ignored=("node_modules", ".git")
  dir=$(find . -maxdepth 2 -type d 2>/dev/null | fzf +m || pwd)

  cd $dir
}


export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export EDITOR="vim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=/Users/dentynok/.meteor:$PATH
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib
