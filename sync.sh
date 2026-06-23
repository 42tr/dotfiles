#!/bin/bash

if [ -e ~/.oh-my-zsh/themes/42tr.zsh-theme ]; then
  cp ~/.oh-my-zsh/themes/42tr.zsh-theme .oh-my-zsh/themes/
fi

if [ -e ~/Library/Rime/default.custom.yaml ]; then
  cp ~/Library/Rime/default.custom.yaml Library/Rime/
fi

if [ -e ~/Library/Rime/squirrel.custom.yaml ]; then
  cp ~/Library/Rime/squirrel.custom.yaml Library/Rime/
fi

if [ -e ~/.alacritty.toml ]; then
  cp ~/.alacritty.toml .alacritty.toml
fi

if [ -e ~/.tmux.conf ]; then
  cp ~/.tmux.conf .tmux.conf
fi
