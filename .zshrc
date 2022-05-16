# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/p10k.zsh ]] || source ~/.zsh/p10k.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
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
alias yum='dnf'
alias vi='nvim'
alias vim='nvim'
