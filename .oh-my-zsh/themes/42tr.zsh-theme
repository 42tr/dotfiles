# ===== 基础设置 =====
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""   # 关闭默认主题，使用自定义 PROMPT

plugins=(git)

source $ZSH/oh-my-zsh.sh


# ===== Git 状态配置 =====
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}➦"


# ===== 提示符符号（root / 普通用户） =====
function prompt_char {
  if [ $UID -eq 0 ]; then
    echo "%{$fg[red]%}#%{$reset_color%}"
  else
    echo "%{$fg[green]%}%{$reset_color%}"
  fi
}


# ===== Vim 后台检测 =====
function vim_bg_info() {
  if [[ -n "$VIM" ]]; then
    echo " %{$fg[yellow]%}⚡%{$reset_color%}"
  fi
}


# ===== Python 虚拟环境 =====
function python_venv_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo " %{$fg[yellow]%} $(basename $VIRTUAL_ENV)%{$reset_color%}"
  fi
}


# ===== 系统图标 =====
function os_icon() {
  case "$OSTYPE" in
    darwin*)  echo "%{$fg[magenta]%}%{$reset_color%}" ;;
    linux*)   echo "%{$fg[blue]%}%{$reset_color%}" ;;
    *)        echo "%{$fg[cyan]%}💻%{$reset_color%}" ;;
  esac
}


# ===== 主提示符（单行极简风） =====
PROMPT='%(?,,%{$fg[red]%}FAIL%{$reset_color%} )
$(os_icon) %{$fg[magenta]%}%~%{$reset_color%}$(git_prompt_info)$(git_prompt_ahead)$(python_venv_info)$(vim_bg_info)
$(prompt_char) '
