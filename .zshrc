export ZSH=~/.oh-my-zsh
ZSH_THEME="lambda"

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
export PATH=$PATH:~/.local/share/stowsh

source ~/.zsh-aliases
source $ZSH/oh-my-zsh.sh
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Scripts
source ~/scripts/tmuxinator-fzf.sh
source ~/scripts/startup.sh


plugins=(
  zsh-autosuggestions
  git
  vi-mode
  history-substring-search
)

# Attach tmux on start
# if [ "$TMUX" = "" ]; then tmux new -As0; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
quick_cd() {
  #ignored=("node_modules", ".git")
  dir=$(find . -maxdepth 2 -type d 2>/dev/null | fzf +m || pwd)

  cd $dir
}


export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export EDITOR="vim"

source /Users/dentynok/.docker/init-zsh.sh || true # Added by Docker Desktop

