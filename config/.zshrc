# PROMPT
if [ $USER != root ] ; then
	PROMPT='[%n@%m %~]% $ '
else
	PROMPT='%B%F{red}[%n@%m %~]% #%f%b '
fi

# AUTO SUGGESTIONS
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Home, End and Del Key Bindings Fedora
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "\e[3~" delete-char

# Forward and Backward - word with ALT
# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# Forward and Backward - word CTRL      
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Alias
alias ssh='ssh -R 3128:localhost:3128'
alias vi='nvim'
alias vim='nvim'
alias sudo='sudo '
alias yum='dnf'
