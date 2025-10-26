# ===== Git 状态配置 =====
# ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[cyan]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%}➦"

# ===== 提示符符号（root 为红色 #，普通用户为 $） =====
function prompt_char {
  if [ $UID -eq 0 ]; then
    echo "%{$fg_bold[red]%}#%{$reset_color%}"
  else
    echo "%{$fg_bold[green]%}%{$reset_color%}"
  fi
}


# ===== 检测 Vim 背景状态（可选） =====
function vim_bg_info() {
  if [[ -n "$VIM" ]]; then
    echo " ⚡"
  fi
}


# ===== 检测 Python 虚拟环境 =====
# function python_venv_info() {
#   if [[ -n "$VIRTUAL_ENV" ]]; then
#     echo "%{$fg_bold[cyan]%}($(basename $VIRTUAL_ENV))%{$reset_color%} "
#   fi
# }
function python_venv_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "%{$fg_bold[yellow]%} $(basename $VIRTUAL_ENV_PROMPT)%{$reset_color%} "
  fi
}

# ===== 系统图标（自动判断 mac / linux） =====
function os_icon() {
  case "$OSTYPE" in
    darwin*)  echo "%{$fg_bold[magenta]%}%{$reset_color%}" ;;
    linux*)   echo "%{$fg_bold[blue]%}%{$reset_color%}" ;; # Nerd Font: Linux 图标
    *)        echo "%{$fg_bold[cyan]%}💻%{$reset_color%}" ;;
  esac
}

# ===== 主提示符（单行） =====
PROMPT='%(?, ,%{$fg_bold[red]%}FAIL%{$reset_color%})
$(os_icon) %{$fg_bold[magenta]%}%~%{$reset_color%}$(git_prompt_info)$(git_prompt_ahead)%{$reset_color%} $(python_venv_info) $(vim_bg_info)
$(prompt_char) '

