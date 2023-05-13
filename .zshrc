source ~/.zsh-aliases
source $HOME/Projects/zsh-lambda-theme/zsh-lambda.zsh-theme

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
#plug "$HOME/Projects/zap-lambda-theme"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/vim"


#OktaAWSCLI
if [[ -f "$HOME/.okta/bash_functions" ]]; then
    . "$HOME/.okta/bash_functions"
fi
if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then
    PATH="$HOME/.okta/bin:$PATH"
fi

#fzf directory and cd
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
quick_cd() {
  #ignored=("node_modules", ".git")
  dir=$(find . -maxdepth 2 -type d 2>/dev/null | fzf +m || pwd)

  cd $dir
}


export EDITOR="vim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
