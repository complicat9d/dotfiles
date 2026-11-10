# --- Ghostty --- 
alias ssh='ghostty +ssh --'
export EDITOR=nvim
export VISUAL=nvim

# --- fzf ---
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 40% --layout=reverse --border
  --info=inline
  --bind "ctrl-/:toggle-preview"
  --bind "ctrl-y:execute-silent(echo -n {+} | pbcopy)"'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :300 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind '?:toggle-preview'"

# --- XDG ---
# zsh
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# ansible
export ANSIBLE_HOME="$XDG_DATA_HOME/ansible"

# rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"

# python / jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export MPLCONFIGDIR="$XDG_CONFIG_HOME/matplotlib"

# history files
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"

# subversion
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# user scripts
export PATH="$HOME/.local/bin:$PATH"

# --- starship ---
eval "$(starship init zsh)"

# --- ls alias ---
alias ls='eza'
alias ll='eza -la --git'
alias lt='eza --tree --level=2'

# --- zsh-completion ---
export LS_COLORS="di=1;94:ln=96:ex=1;92:fi=0:or=91:so=93:pi=93"
zmodload zsh/complist
autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
