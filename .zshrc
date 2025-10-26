export VIRTUAL_ENV_DISABLE_PROMPT=1
alias show="viu"
alias help="mdcat ~/README.md"
alias office="open -a \"LibreOffice\""
alias t="touch"
alias wt='curl wttr.in/nanjing'

# alias fscp='ssh pi "find /disk/safe -type f" | fzf | xargs -I{} scp pi:"{}" .'
fdown() {
  local server=${1:-pi}       # 第一个参数：服务器
  local remote_path=${2:-/disk/safe} # 第二个参数：远程目录
  local local_dir=${3:-.}              # 第三个参数：本地下载目录

  ssh "$server" "find '$remote_path' -type f" | \
    fzf --prompt="Select file to download > " | \
    xargs -I{} scp $server:"{}" $local_dir
}

fup() {
  local file=${1:-}                   # 第一个参数：要上传的本地文件/文件夹
  local server=${2:-pi}               # 第二个参数：服务器
  local remote_root=${3:-/disk/safe}  # 第三个参数：可选，搜索起始目录
  local delete_after=${4:-true}       # 第四个参数：是否删除本地文件

  if [[ -z "$file" ]]; then
    echo "Usage: fup <local_file_or_dir> [server] [remote_root] [delete_after:true|false]"
    return 1
  fi

  # 在远程用 fzf 选择一个目录
  local target_dir
  target_dir=$(ssh "$server" "find '$remote_root' -type d 2>/dev/null" | fzf --prompt='Select remote dir > ')
  if [[ -z "$target_dir" ]]; then
    echo "❌ Upload canceled."
    return 1
  fi

  echo "📤 Uploading '$file' → $server:$target_dir"

  if [[ -d "$file" ]]; then
    # 上传目录
    rsync -avz --progress "$file" "$server:$target_dir/"
  else
    # 上传单个文件
    scp "$file" "$server:$target_dir/"
  fi

  if [[ "$delete_after" == "true" ]]; then
    if [[ -d "$file" ]]; then
      rm -rf "$file"
    else
      rm -f "$file"
    fi
    echo "🧹 Local deleted: $file"
  fi
}

fzf_nvim() {
  if [ -n "$1" ]; then
    nvim "$@"
  else
    local file
    file=$(fd . | fzf --preview 'bat --style=numbers --color=always {}')
    [ -n "$file" ] && nvim "$file"
  fi
}

[[ -x $(command -v nvim) ]] && alias vi=fzf_nvim

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="42tr"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

. "$HOME/.local/bin/env"

export PATH="$PATH:$(go env GOPATH)/bin"

run_tmux() {
  tmux -f ~/.tmux.conf new-session -A -s main
}

if [[ -z $TMUX ]];then
  exec run_tmux
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
